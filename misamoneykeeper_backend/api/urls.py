from django.urls import path
from . import views

urlpatterns = [
    path('misamoneykeeper/login', views.login, name='login'),
    # path('misamoneykeeper/signup', views.signup, name='signup'),
    # path('misamoneykeeper/logout', views.logout, name='logout'),
]