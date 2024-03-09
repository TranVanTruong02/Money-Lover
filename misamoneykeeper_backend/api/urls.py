from django.urls import path
from .views import UserRegisterAdmin, UserRegisterView, UserLoginView, UserLogoutView, AccountAddView, AccountView, AccountUpdateView, AccountDeleteView, AccountStopUsingView, RefreshAccessToken, PayAddView, BalanceAdjustmentView, CategoryView, HistoryView, RecentNotesView, RecentNotesHomeView, CategoryCollectView

urlpatterns = [
    # Admin
    path('misamoneykeeper/admin/register', UserRegisterAdmin.as_view(), name='register admin'),

    #Client
    path('misamoneykeeper/register', UserRegisterView.as_view(), name='register'),
    path('misamoneykeeper/login', UserLoginView.as_view(), name='login'),
    path('misamoneykeeper/logout', UserLogoutView.as_view(), name='logout'),
    path('misamoneykeeper/refreshaccesstoken', RefreshAccessToken.as_view(), name='refresh access token'),
    path('misamoneykeeper/addpay', PayAddView.as_view(), name='Pay Add'),
    path('misamoneykeeper/balance/adjustment', BalanceAdjustmentView.as_view(), name='Balance Adjustment'),
    path('misamoneykeeper/category', CategoryView.as_view(), name='category'),
    path('misamoneykeeper/category/collect', CategoryCollectView.as_view(), name='category collect'),
    path('misamoneykeeper/history', HistoryView.as_view(), name='history'),
    path('misamoneykeeper/recnetnote/home', RecentNotesHomeView.as_view(), name='recnet note home'),
    path('misamoneykeeper/recnetnote', RecentNotesView.as_view(), name='history'),
    path('misamoneykeeper/account', AccountView.as_view(), name='Account View'),
    path('misamoneykeeper/account/add', AccountAddView.as_view(), name='Add Account'),
    path('misamoneykeeper/account/update', AccountUpdateView.as_view(), name='Account Update'),
    path('misamoneykeeper/account/delete', AccountDeleteView.as_view(), name='Account Delete'),
    path('misamoneykeeper/account/stopusing', AccountStopUsingView.as_view(), name='Account Stop Using'),
]