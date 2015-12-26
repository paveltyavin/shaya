from django.db import models


class ChartPoint(models.Model):
    created = models.DateTimeField()
    value = models.IntegerField()

    class Meta:
        ordering = ('created',)


class Follower(models.Model):
    username = models.CharField(max_length=256, default='')
    id = models.CharField(primary_key=True, max_length=256)
    full_name = models.CharField(max_length=256, default='')
    profile_picture = models.URLField(default='')

    is_active = models.BooleanField(default=True, verbose_name='Активен')
    inactive_date = models.DateTimeField(verbose_name='Дата отписка', default=None, null=True)


class FollowerPresence(models.Model):
    follower = models.ForeignKey('Follower')
    created = models.DateTimeField()
    is_active = models.BooleanField(default=True, verbose_name='Активен')
