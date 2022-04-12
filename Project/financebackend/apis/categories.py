from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from financebackend.apis.linear import get_thresholds
from financebackend.models import *
from datetime import *

from financebackend.serializers import category_serializer

@api_view(['GET'])
def get_categorys_with_amounts(request):
    user = User.objects.get(id = request.headers['userID'])
    categories = Category.objects.all().filter(user = user)
    serializer = category_serializer(categories, many = True)
    lastMonth = datetime.now() - timedelta(days=30)
    transactions = Transaction.objects.all().filter(
            user=user, date_time__date__range=(lastMonth, datetime.now()))
    lastMonth30days = get_thresholds(request.headers['userID'])
    for i in serializer.data:
        my_id = i["id"]
        amount = 0
        for j in transactions:
            if j.category.id == my_id:
                amount += j.amount
        i["amount"] = amount
        if my_id in lastMonth30days:
            if i["amount"] > lastMonth30days[my_id]:
                i["is_exceeded"] = True
            else:
                i["is_exceeded"] = False
        else:
            i["is_exceeded"] = False
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
    print(data['is_expense'])
    my_category = Category.objects.create(
        name = data['name'],
        user = User.objects.get(id = data["user"]),
        is_expense = data['is_expense'] == "true",
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