# Generated by Django 5.0.1 on 2024-03-09 08:45

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0014_alter_notification_id_n'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='helpInfomation',
            new_name='helpInformation',
        ),
        migrations.AlterModelTable(
            name='helpinformation',
            table='helpInformation',
        ),
    ]
