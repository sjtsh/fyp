# Generated by Django 4.0 on 2022-01-11 16:42

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('financebackend', '0008_remove_transaction_is_expense'),
    ]

    operations = [
        migrations.AlterField(
            model_name='category',
            name='is_exceeded',
            field=models.BooleanField(default=False),
        ),
    ]
