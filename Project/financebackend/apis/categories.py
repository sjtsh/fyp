from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from financebackend.models import *

from financebackend.serializers import category_serializer

@api_view(['GET'])
def get_categorys_with_amounts(request):
    user = User.objects.get(id = request.headers['userID'])
    categories = Category.objects.all().filter(user = user)
    serializer = category_serializer(categories, many = True)
    transactions = Transaction.objects.all().filter(user = user)
    for i in serializer.data:
        my_id = i["id"]
        amount = 0
        for j in transactions:
            if j.category.id == my_id:
                amount += j.amount
        i["amount"] = amount
    a = serializer.data
    a.sort(key=lambda x: x['amount'], reverse = True)
    return Response(a)


@api_view(['GET'])
def get_category(request, pk):
    category = Category.objects.get(id=pk)
    serializer = category_serializer(category, many = False)
    return Response(serializer.data)

@api_view(['POST'])
def insert_category(request):
    data = request.data
    my_category = Category.objects.create(
        name = data['name'],
        user = User.objects.get(id = data["user"]),
        is_expense = bool(data['is_expense']),
    )
    for i in data:
        if i != 'name' and i != 'user' and i != 'is_expense':
            related_word = RelatedWord.objects.create(text = i, impact = data[i], category = my_category)
    serializer = category_serializer(my_category, many = False)
    i = serializer.data
    i['amount'] = 0
    return Response(i)
    
@api_view(['PUT'])
def update_category(request, pk):
    data = request.data
    category = Category.objects.get(id=pk)
    serializer = category_serializer(category, data = request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)

@api_view(['DELETE'])
def delete_category(request, pk):
    category = Category.objects.get(id=pk)
    category.delete()
    return Response('Category was deleted!')