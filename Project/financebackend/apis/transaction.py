from django.db.models.fields import DateTimeCheckMixin, DateTimeField
from datetime import datetime, timedelta
from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from financebackend.models import *
from django.utils import timezone
from financebackend.apis.linear import *
import asyncio
from financebackend.serializers import transaction_serializer


@api_view(['GET'])
def get_transactions_by_time(request):
    user1 = User.objects.get(id=request.headers['userID'])
    dropdownValue = request.headers['dropdownValue']
    now = timezone.now()
    if dropdownValue == "Year":
        lastYear = now - timedelta(days=365)
        transactions = Transaction.objects.all().filter(
            user=user1,  date_time__date__range=(lastYear, now))
    elif dropdownValue == "Month":
        lastMonth = now - timedelta(days=30)
        transactions = Transaction.objects.all().filter(
            user=user1, date_time__date__range=(lastMonth, now))
    elif dropdownValue == "Day":
        lastDay = now - timedelta(days=1)
        transactions = Transaction.objects.all().filter(
            user=user1,  date_time__date__range=(lastDay, now))
    else:
        transactions = Transaction.objects.all().filter(user=user1)
    serializer = transaction_serializer(transactions, many=True)
    for i in serializer.data:
        id = i["category"]
        i["category"] = Category.objects.get(id=i["category"]).name
        i["is_expense"] = Category.objects.get(id=id).is_expense
    i = serializer.data
    i.sort(key=lambda x: x['date_time'], reverse=True)
    return Response(i)


@api_view(['GET'])
def get_transaction(request, pk):
    transaction = Transaction.objects.get(id=pk)
    serializer = transaction_serializer(transaction, many=False)
    a = serializer.data
    a["category"] = Category.objects.get(id=serializer.data["category"]).name
    a["is_expense"] = Category.objects.get(
        id=serializer.data["category"]).is_expense
    return Response(a)


@api_view(['POST'])
def insert_transaction(request):
    data = request.data
    transaction = Transaction.objects.create(
        user=User.objects.get(id=data["user"]),
        category=Category.objects.get(id=data["category"]),
        remark=data["remark"],
        amount=float(data['amount']),
    )
    serializer = transaction_serializer(transaction, many=False)
    a = serializer.data
    a["category"] = Category.objects.get(id=serializer.data["category"]).name
    a["is_expense"] = Category.objects.get(
        id=serializer.data["category"]).is_expense
    user = User.objects.get(id=data['user'])
    if(a["is_expense"]):
        user.bank_balance -= float(data['amount'])
        user.save()
    else:
        user.bank_balance += float(data['amount'])
        user.save()
    return Response(a)


@api_view(['PUT'])
def update_transaction(request, pk):
    transaction = Transaction.objects.get(id=pk)
    serializer = transaction_serializer(transaction, data=request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)


@api_view(['DELETE'])
def delete_transaction(request, pk):
    transaction = Transaction.objects.get(id=pk)
    transaction.delete()
    return Response('transaction was deleted!')
