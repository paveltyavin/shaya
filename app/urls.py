from django.conf.urls import url
from app.views import HomeView, FollowerView


urlpatterns = [
    url(r'^$', HomeView.as_view()),
    url(r'^api/follower/$', FollowerView.as_view()),
]
