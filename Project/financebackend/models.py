from django.db import models
from django.db.models.fields import DateField

# Create your models here.

class Gender(models.Model):
    name = models.TextField()
    
    def __str__(self):
        return self.name

    
class Theme(models.Model):
    name = models.TextField()
    
    def __str__(self):
        return self.name


class Avatar(models.Model):
    avatar_url = models.TextField()
    gender = models.ForeignKey(Gender, on_delete=models.CASCADE)
    min_age_estimation = models.IntegerField()
    max_age_estimation = models.IntegerField()
    
    def __str__(self):
        return self.avatar_url


class User(models.Model):
    email = models.EmailField(blank=True, null=True)
    bank_balance = models.FloatField()
    is_deactivated = models.BooleanField(default=False)
    pin_code = models.IntegerField(blank=True, null = True)
    theme_preference = models.ForeignKey(Theme, on_delete=models.CASCADE)
    avatar = models.ForeignKey(Avatar, on_delete=models.CASCADE)
    name = models.TextField()
    monthly_target_saving = models.FloatField()
    date_time = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.name

class Category(models.Model):
    name = models.TextField()
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    is_exceeded = models.BooleanField(default=False)
    is_expense = models.BooleanField()
    is_deactivated = models.BooleanField(default=False)
    date_time = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.name


class RelatedWord(models.Model):
    text = models.TextField()
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    impact = models.FloatField()
    is_deactivated = models.BooleanField(default=False)
    date_time = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.text

    
class Transaction(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    remark = models.TextField()
    amount = models.FloatField()
    date_time = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        if(len(self.remark) < 10):
            return self.remark
        else:
            return self.remark[0:10]


class Correction(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    correction = models.FloatField()
    remark = models.TextField()
    date_time = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return str(self.correction)