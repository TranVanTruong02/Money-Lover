# Generated by Django 5.0.1 on 2024-03-01 07:48

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0008_categorydetails_cad_type'),
    ]

    operations = [
        migrations.AlterField(
            model_name='pay',
            name='p_date',
            field=models.DateField(),
        ),
    ]
