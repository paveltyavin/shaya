# coding=utf-8
from __future__ import unicode_literals
from django.core.management.base import BaseCommand
from django.conf import settings
from django.utils.timezone import now
import requests
import json
from app.models import ChartPoint, Follower, FollowerPresence


class Command(BaseCommand):
    def get_followers(self):
        follower_id_set = set([])
        url = 'https://api.instagram.com/v1/users/self/follows?access_token={}'.format(settings.INSTAGRAM_ACCESS_TOKEN)
        while url:
            r = requests.get(url)
            data = json.loads(r.text)
            if r.status_code != 200:
                break
            pagination = data['pagination']
            for follower_data in data['data']:
                follower_id = follower_data['id']
                follower, created = Follower.objects.get_or_create(
                    id=follower_id,
                    defaults={
                        'username': follower_data['username'],
                        'profile_picture': follower_data['profile_picture'],
                        'full_name': follower_data['full_name'],
                        'is_active': True,
                    },
                )
                if not follower.is_active:
                    follower.is_active = True
                    follower.save()
                follower_id_set.add(follower_id)
                FollowerPresence.objects.create(
                    follower=follower,
                    created=now(),
                    is_active=True,
                )

            url = pagination.get('next_url')

        other_follower_qs = Follower.objects.exclude(id__in=follower_id_set)

        other_follower_qs.filter(
            is_active=True,
        ).update(
            is_active=False,
            inactive_date=now(),
        )

        for follower in other_follower_qs:
            FollowerPresence.objects.create(
                follower=follower,
                created=now(),
                is_active=False,
            )

    def get_value(self):
        url = 'https://api.instagram.com/v1/users/{}'.format(settings.INSTAGRAM_USER_ID)
        r = requests.get(url, params={
            'client_id': settings.INSTAGRAM_CLIENT_ID,
        })
        data = json.loads(r.text)
        value = data['data']['counts']['followed_by']
        ChartPoint.objects.create(
            value=value,
            created=now(),
        )

    def handle(self, *args, **options):
        self.get_value()
        self.get_followers()
