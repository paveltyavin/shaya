# coding=utf-8
from __future__ import unicode_literals
from django.core.management.base import BaseCommand
from django.conf import settings
from django.utils.timezone import now
import requests
import json
from app.models import ChartPoint


class Command(BaseCommand):
    def handle(self, *args, **options):
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
