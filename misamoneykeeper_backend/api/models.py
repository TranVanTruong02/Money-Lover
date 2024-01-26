from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.

# Table User
class User(models.Model):
    user_id = models.AutoField(primary_key=True)
    u_first_name = models.CharField(max_length=75, default='')
    u_last_name = models.CharField(max_length=75, default='')
    u_type = models.IntegerField(default=1, choices=((1, 'User'), (2, 'Admin')))
    u_email = models.CharField(max_length=100, default='')
    u_mobile = models.CharField(max_length=15, default='')
    u_mobile_code = models.CharField(max_length=6, default='')
    u_password = models.CharField(max_length=100, default='')
    u_auth_token = models.CharField(max_length=100, default='')
    u_device_token = models.CharField(max_length=150)
    u_reset_code = models.CharField(max_length=6, default='0000')
    u_number_coins = models.IntegerField(default=0)
    u_status = models.IntegerField(default=1, choices=((1, 'Active'), (2, 'Deleted')))
    u_created_date = models.DateTimeField(auto_now_add=True)
    u_modify_date = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.u_email

class UserDetails(models.Model):
    user_details_id = models.AutoField(primary_key=True)
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)
    ud_name = models.CharField(max_length=100)
    ud_image = models.ImageField(upload_to='user_images/')
    ud_birthday = models.DateTimeField(auto_now=True)
    ud_gender = models.CharField(max_length=10) 
    ud_job = models.CharField(max_length=100)
    ud_status = models.IntegerField(choices=((1, 'Active'), (2, 'Deleted')))
    ud_created_date = models.DateTimeField(auto_now_add=True)
    ud_modify_date = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.ud_name