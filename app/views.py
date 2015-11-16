from django.utils.timezone import now
from django.views.generic.base import TemplateView
from rest_framework.generics import ListAPIView
from rest_framework import serializers
from app.models import ChartPoint


class HomeView(TemplateView):
    template_name = 'home.html'


class ChartPointSerializer(serializers.ModelSerializer):
    class Meta:
        model = ChartPoint
        fields = [
            'created',
            'value',
        ]


class FollowerView(ListAPIView):
    serializer_class = ChartPointSerializer

    def get_queryset(self):
        return ChartPoint.objects.filter(created__lte=now())
