from calendar import month
from unicodedata import category
from xmlrpc.client import DateTime
from django.http import Http404, JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.http import HttpResponseNotFound
from datetime import datetime, timedelta
from financebackend.models import *
import pandas as pd
from sklearn.linear_model import LinearRegression

lr = LinearRegression()
iteration = 0

# 0 is most recent
# @api_view(['GET'])
# 0 is most recent


@api_view(['GET'])
def radar(request, pk):
    user = User.objects.get(id=pk)
    now = (datetime.now() + timedelta(days=1)
           ).replace(hour=0, minute=0, second=0)
    expenseThisMonth = sum(Transaction.objects.all().filter(user=user, date_time__date__range=(
        now - timedelta(days=now.day), now), category__is_expense=True, ).values_list('amount', flat=True))
    incomeThisMonth = sum(Transaction.objects.all().filter(user=user, date_time__date__range=(
        now - timedelta(days=now.day), now), category__is_expense=False, ).values_list('amount', flat=True))
    savingThisMonth = max(0, incomeThisMonth - expenseThisMonth)
    expenseLastMonth = sum(Transaction.objects.all().filter(user=user, date_time__date__range=(
        now - timedelta(days=now.day+30), now - timedelta(days=30)), category__is_expense=True, ).values_list('amount', flat=True))
    incomeLastMonth = sum(Transaction.objects.all().filter(user=user, date_time__date__range=(
        now - timedelta(days=now.day+30), now - timedelta(days=30)), category__is_expense=False, ).values_list('amount', flat=True))
    savingLastMonth = max(0, incomeLastMonth - expenseLastMonth)
    dictionary = {"last_month": {"expense": expenseLastMonth, "income": incomeLastMonth, "saving": savingLastMonth},
                  "this_month": {"expense": expenseThisMonth, "income": incomeThisMonth, "saving": savingThisMonth}}
                  
    return Response(dictionary)

# 0 is most recent


@api_view(['GET'])
def train_user_expenses(request, pk):
    user = User.objects.get(id=pk)
    print("Started training")

    expenseLast30days = []
    expenseLastIterationDays = []
    timeStampLastIterationDays = []
    now = (datetime.now() + timedelta(days=1)
           ).replace(hour=0, minute=0, second=0)
    sinceCreated = abs((user.date_time.replace(
        tzinfo=None, hour=0, minute=0, second=0) - now).days)
    iteration = min(sinceCreated, 365)

    for i in range(iteration):
        # print(str(now - timedelta(days=i+1)) +" " + str(now - timedelta(days=i)))
        items = Transaction.objects.all().filter(user=user, date_time__date__range=(
            now - timedelta(days=i+1), now - timedelta(days=i+1)), category__is_expense=True, )
        total_price = sum(items.values_list('amount', flat=True))
        items = Transaction.objects.all().filter(user=user, date_time__date__range=(
            now - timedelta(days=i+1), now - timedelta(days=i+1)), category__is_expense=False, )
        income_price = sum(items.values_list('amount', flat=True))
        total_price = income_price - total_price
        expenseLastIterationDays.append(total_price)
        timeStampLastIterationDays.append(i)
    timeStampLastIterationDays.reverse()
    expenseLastIterationDays.reverse()
    expenseLast30days.reverse()
    trainingDataX = pd.DataFrame(
        {"day": timeStampLastIterationDays})
    trainingDataY = pd.DataFrame(
        {"expense": expenseLastIterationDays})
    lr.fit(trainingDataX, trainingDataY)
    return Response("true")

# 0 is most recent


@api_view(['GET'])
def predict_user_expenses(request, pk):
    train(pk)
    user = User.objects.get(id=pk)

    expenseLast30days = []
    lastMonth30days = []
    now = (datetime.now() + timedelta(days=1)
           ).replace(hour=0, minute=0, second=0)
    sinceCreated = abs((user.date_time.replace(
        tzinfo=None, hour=0, minute=0, second=0) - now).days)
    iteration = min(sinceCreated, 365)

    for i in range(45):

        items = Transaction.objects.all().filter(user=user, date_time__date__range=(
            now - timedelta(days=i+1), now - timedelta(days=i+1)), category__is_expense=True, )
        total_price = sum(items.values_list('amount', flat=True))
        items = Transaction.objects.all().filter(user=user, date_time__date__range=(
            now - timedelta(days=i+1), now - timedelta(days=i+1)), category__is_expense=False, )
        income_price = sum(items.values_list('amount', flat=True))
        total_price = total_price
        # print(str(now - timedelta(days=i+1)) +" " + str(now - timedelta(days=i)))
        if(i < 15):
            expenseLast30days.append(total_price)
        else:
            lastMonth30days.append(total_price)
    expenseLast30days.reverse()
    lastMonth30days.reverse()
    testingDataX = pd.DataFrame(
        {"day": [i for i in range(iteration + 15, iteration, -1)]})
    y_pred = lr.predict(testingDataX)
    resultPredicted = {i: y_pred[i][0] for i in range(14, -1, -1)}
    resultActual = {i: expenseLast30days[i] for i in range(14, -1, -1)}
    lastMonth = {i: lastMonth30days[i] for i in range(29, -1, -1)}
    result = {"actual": resultActual,
              "predicted": resultPredicted, "last_month": lastMonth}
    return Response(result)

# 0 is most recent


def get_thresholds(pk):
    user = User.objects.get(id=pk)
    total_income = 0
    total_expense = 0
    lastMonth30days = {}
    month_end = datetime.now().replace(hour=0, minute=0, second=0, day=1)
    month_start = (datetime.now() - timedelta(days=30)
                   ).replace(hour=0, minute=0, second=0, day=1)
    transactions = Transaction.objects.all().filter(user=user).filter(
        date_time__date__range=(month_start, month_end))

    for i in transactions:
        if i.category.is_expense:
            total_expense += i.amount
            if i not in lastMonth30days:
                lastMonth30days[i.category.id] = i.amount
            else:
                lastMonth30days[i.category.id] += i.amount
        else:
            total_income += i.amount

    if user.monthly_target_saving > total_income:
        for i in lastMonth30days:
            lastMonth30days[i] = 0
    else:
        for i in lastMonth30days.keys():
            lastMonth30days[i] = (
                lastMonth30days[i] / total_expense)*(total_income - user.monthly_target_saving)

    return lastMonth30days


def train(pk):
    user = User.objects.get(id=pk)
    print("Started training")

    expenseLast30days = []
    expenseLastIterationDays = []
    timeStampLastIterationDays = []
    now = (datetime.now() + timedelta(days=1)
           ).replace(hour=0, minute=0, second=0)
    sinceCreated = abs((user.date_time.replace(
        tzinfo=None, hour=0, minute=0, second=0) - now).days)
    iteration = min(sinceCreated, 365)

    for i in range(iteration):
        # print(str(now - timedelta(days=i+1)) +" " + str(now - timedelta(days=i)))
        items = Transaction.objects.all().filter(user=user, date_time__date__range=(
            now - timedelta(days=i+1), now - timedelta(days=i+1)), category__is_expense=True, )
        total_price = sum(items.values_list('amount', flat=True))
        items = Transaction.objects.all().filter(user=user, date_time__date__range=(
            now - timedelta(days=i+1), now - timedelta(days=i+1)), category__is_expense=False, )
        income_price = sum(items.values_list('amount', flat=True))
        total_price = income_price - total_price
        expenseLastIterationDays.append(total_price)
        timeStampLastIterationDays.append(i)
    timeStampLastIterationDays.reverse()
    expenseLastIterationDays.reverse()
    expenseLast30days.reverse()
    trainingDataX = pd.DataFrame(
        {"day": timeStampLastIterationDays})
    trainingDataY = pd.DataFrame(
        {"expense": expenseLastIterationDays})
    lr.fit(trainingDataX, trainingDataY)
    return Response("true")
