from app.models import ChartPoint, Follower, FollowerPresence
from rest_framework import serializers


class ChartPointSerializer(serializers.ModelSerializer):
    class Meta:
        model = ChartPoint
        fields = [
            'created',
            'value',
        ]


class FollowerPresenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = FollowerPresence
        fields = [
            'created',
            'is_active',
        ]


class FollowerListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Follower
        fields = [
            'id',
            'username',
            'is_active',
            'inactive_date',
            'profile_picture',
        ]


class FollowerDetailSerializer(serializers.ModelSerializer):
    followerpresence_set = FollowerPresenceSerializer(many=True)

    class Meta:
        model = Follower
        fields = [
            'id',
            'username',
            'is_active',
            'inactive_date',
            'profile_picture',
            'followerpresence_set',
        ]
