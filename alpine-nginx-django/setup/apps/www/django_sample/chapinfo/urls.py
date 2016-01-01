from django.conf.urls import url
from django.views.generic import RedirectView

from . import views

app_name = 'chapinfo'
urlpatterns = [
    url(r'^(.+)$', views.generic, name='generic'),
    url(r'^$', RedirectView.as_view(url='/index.html')),
]
