from django.urls import path
from .views import UserRegisterAdmin, UserRegisterView, UserLoginView, UserLogoutView, AccountCreateView, AccountView, RefreshAccessToken

urlpatterns = [
    # Admin
    path('misamoneykeeper/admin/register', UserRegisterAdmin.as_view(), name='register admin'),

    #Client
    path('misamoneykeeper/register', UserRegisterView.as_view(), name='register'),
    path('misamoneykeeper/login', UserLoginView.as_view(), name='login'),
    path('misamoneykeeper/logout', UserLogoutView.as_view(), name='logout'),
    path('misamoneykeeper/refreshaccesstoken', RefreshAccessToken.as_view(), name='refresh access token'),
    path('misamoneykeeper/account/add', AccountCreateView.as_view(), name='Add Account'),
    path('misamoneykeeper/account', AccountView.as_view(), name='Account View'),
]