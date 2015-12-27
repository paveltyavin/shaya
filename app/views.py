from django.views.generic.base import TemplateView
from rest_framework import filters
from rest_framework.generics import ListAPIView, RetrieveAPIView
from rest_framework.pagination import PageNumberPagination
from app.models import ChartPoint, Follower
from . import serializers


class Page10Pagination(PageNumberPagination):
    page_size = 10
    page_size_query_param = 'page_size'


class HomeView(TemplateView):
    template_name = 'home.html'


class ChartView(ListAPIView):
    serializer_class = serializers.ChartPointSerializer
    queryset = ChartPoint.objects.all()


class FollowerListView(ListAPIView):
    pagination_class = Page10Pagination
    serializer_class = serializers.FollowerListSerializer
    queryset = Follower.objects.all()
    filter_backends = (filters.DjangoFilterBackend, filters.OrderingFilter, filters.SearchFilter)
    filter_fields = (
        'is_active',
    )
    ordering_fields = (
        'inactive_date',
    )
    search_fields = (
        'username',
        'full_name',
    )


class FollowerDetailView(RetrieveAPIView):
    serializer_class = serializers.FollowerDetailSerializer
    queryset = Follower.objects.all()