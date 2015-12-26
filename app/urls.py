from django.conf.urls import url
from app import views

urlpatterns = [
    url(r'^api/chart/$', views.ChartView.as_view()),
    url(r'^api/follower/$', views.FollowerListView.as_view()),
    url(r'^api/follower/(?P<pk>\d+)/$', views.FollowerDetailView.as_view()),
    url(r'^', views.HomeView.as_view()),
]
