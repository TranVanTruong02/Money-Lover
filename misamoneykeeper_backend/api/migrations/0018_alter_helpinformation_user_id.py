# Generated by Django 5.0.1 on 2024-03-09 08:53

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0017_alter_helpinformation_user_id'),
    ]

    operations = [
        migrations.AlterField(
            model_name='helpinformation',
            name='user_id',
            field=models.ForeignKey(default=0, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
    ]