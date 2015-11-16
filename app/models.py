from django.db import models


class ChartPoint(models.Model):
    created = models.DateTimeField()
    value = models.IntegerField()

    class Meta:
        ordering = ('created',)
