from django.views.generic.base import TemplateView
from rest_framework.generics import ListAPIView, RetrieveAPIView
from rest_framework import serializers
from rest_framework.pagination import PageNumberPagination
from app.models import ChartPoint, Follower, FollowerPresence


class Page10Pagination(PageNumberPagination):
    page_size = 10


class HomeView(TemplateView):
    template_name = 'home.html'


class ChartPointSerializer(serializers.ModelSerializer):
    class Meta:
        model = ChartPoint
        fields = [
            'created',
            'value',
        ]


class FollowerListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Follower
        fields = [
            'id',
            'username',
            'is_active',
            'inactive_date',
        ]


class FollowerPresenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = FollowerPresence
        fields = [
            'created',
            'is_active',
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
            'followerpresence_set',
        ]


class ChartView(ListAPIView):
    serializer_class = ChartPointSerializer
    queryset = ChartPoint.objects.all()


class FollowerListView(ListAPIView):
    pagination_class = Page10Pagination
    serializer_class = FollowerListSerializer
    queryset = Follower.objects.all()


class FollowerDetailView(RetrieveAPIView):
    serializer_class = FollowerDetailSerializer
    queryset = Follower.objects.all()
