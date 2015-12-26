# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0002_follower_followerpresence'),
    ]

    operations = [
        migrations.AddField(
            model_name='follower',
            name='inactive_date',
            field=models.DateTimeField(verbose_name='Дата отписка', null=True, default=None),
        ),
    ]
