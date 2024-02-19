from django.db import models
from django.contrib.auth.models import AbstractUser

# Table User
class User(AbstractUser):

    username = None

    type = models.PositiveIntegerField(default=1, choices=((1, 'User'), (2, 'Admin')))
    email = models.EmailField(max_length=100, default='', unique=True)
    mobile = models.CharField(max_length=15, default='')
    mobile_code = models.CharField(max_length=6, default='')
    password = models.CharField(max_length=100, default='')
    access_token = models.CharField(max_length=255, default='')
    refresh_token = models.CharField(max_length=255, default='')
    access_token_expiration = models.DateTimeField(auto_now_add=True)
    refresh_token_expiration = models.DateTimeField(auto_now_add=True)
    reset_code = models.CharField(max_length=6, default='0000')
    number_coins = models.IntegerField(default=0)
    modify_date = models.DateTimeField(auto_now=True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    def __str__(self):
        return self.email
    
    class Meta:
        db_table = 'User'

class Account(models.Model):
    account_id = models.AutoField(primary_key=True)
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)
    ac_name = models.CharField(max_length = 100, default = '')
    ac_money = models.IntegerField(default=0)
    ac_type = models.PositiveIntegerField(default=1, help_text='1: Tiền mặt, 2: Tài khoản ngân hàng, ...')
    ac_bank = models.CharField(max_length = 100, default = '')
    ac_currency = models.CharField(max_length = 100, default = '')
    ac_explanation = models.CharField(max_length = 1000, default = '')
    ac_status = models.IntegerField(default=1, help_text='1: active, 2: deleted')
    ac_created_date = models.DateTimeField(auto_now_add=True)
    ac_modify_date = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.ac_name
    
    class Meta:
        db_table = 'Account'


# AutoField: Một trường số nguyên tự động tăng, thường được sử dụng cho các trường khóa chính.
# CharField: Một trường dữ liệu văn bản có độ dài cố định.
# TextField: Một trường dữ liệu văn bản có độ dài không giới hạn.
# IntegerField: Một trường số nguyên.
# FloatField: Một trường số thực.
# BooleanField: Một trường boolean (True/False).
# DateField: Một trường ngày.
# DateTimeField: Một trường ngày và giờ.
# ForeignKey: Một trường khóa ngoại, được sử dụng để liên kết với một mô hình khác.
# ManyToManyField: Một trường đa nhiều - đa nhiều, được sử dụng để tạo mối quan hệ nhiều - nhiều giữa các mô hình.
# EmailField: Một trường dữ liệu email.
# URLField: Một trường dữ liệu URL.

