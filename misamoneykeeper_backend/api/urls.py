from django.urls import path
from .views import UserRegisterView, UserLoginView

urlpatterns = [
    path('misamoneykeeper/register', UserRegisterView.as_view(), name='register'),
    path('misamoneykeeper/login', UserLoginView.as_view(), name='login'),
#     path('misamoneykeeper/login', views.login, name='login'),
#     # path('misamoneykeeper/signup', views.signup, name='signup'),
#     # path('misamoneykeeper/logout', views.logout, name='logout'),
]