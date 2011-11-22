from django.conf.urls.defaults import patterns, include, url

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    url(r'^$', 'lets.web.views.home', name='home'),
    url(r'^callback/', 'lets.web.views.callback'),
    url(r'^admin/doc/', include("django.contrib.admindocs.urls")),
    url(r'^admin/', include(admin.site.urls)),
)
