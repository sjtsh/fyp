from rest_framework.serializers import ModelSerializer
from .models import *

class category_serializer(ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'

        
class gender_serializer(ModelSerializer):
    class Meta:
        model = Gender
        fields = '__all__'
        
class theme_serializer(ModelSerializer):
    class Meta:
        model = Theme
        fields = '__all__'

class avatar_serializer(ModelSerializer):
    class Meta:
        model = Avatar
        fields = '__all__'

class related_word_serializer(ModelSerializer):
    class Meta:
        model = RelatedWord
        fields = '__all__'

class user_serializer(ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'
        
class transaction_serializer(ModelSerializer):
    class Meta:
        model = Transaction
        fields = '__all__'

class correction_serializer(ModelSerializer):
    class Meta:
        model = Correction
        fields = '__all__'