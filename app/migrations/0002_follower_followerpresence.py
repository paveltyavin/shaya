# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Follower',
            fields=[
                ('username', models.CharField(max_length=256, default='')),
                ('id', models.CharField(max_length=256, primary_key=True, serialize=False)),
                ('full_name', models.CharField(max_length=256, default='')),
                ('profile_picture', models.URLField(default='')),
                ('is_active', models.BooleanField(verbose_name='Активен', default=True)),
            ],
        ),
        migrations.CreateModel(
            name='FollowerPresence',
            fields=[
                ('id', models.AutoField(serialize=False, auto_created=True, primary_key=True, verbose_name='ID')),
                ('created', models.DateTimeField()),
                ('is_active', models.BooleanField(verbose_name='Активен', default=True)),
                ('follower', models.ForeignKey(to='app.Follower')),
            ],
        ),
    ]
