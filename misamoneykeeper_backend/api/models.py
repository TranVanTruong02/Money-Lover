from django.db import models
from django.contrib.auth.models import AbstractUser

# Table User
class User(AbstractUser):

    username = None
    is_staff = None
    is_superuser = None

    type = models.IntegerField(default=1, choices=((1, 'User'), (2, 'Admin')))
    email = models.EmailField(max_length=100, default='', unique=True)
    mobile = models.CharField(max_length=15, default='')
    mobile_code = models.CharField(max_length=6, default='')
    password = models.CharField(max_length=100, default='')
    auth_token = models.CharField(max_length=100, default='')
    reset_code = models.CharField(max_length=6, default='0000')
    number_coins = models.IntegerField(default=0)
    modify_date = models.DateTimeField(auto_now=True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    def __str__(self):
        return self.email
    
    class Meta:
        db_table = 'User'
