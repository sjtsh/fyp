from xmlrpc.client import DateTime
from django.http import Http404, JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.http import HttpResponseNotFound
from datetime import datetime
from financebackend.models import *

from financebackend.serializers import user_serializer


@api_view(['GET'])
def get_users(request):
    users = User.objects.all()
    serializer = user_serializer(users, many=True)
    return Response(serializer.data)


@api_view(['GET'])
def get_user(request, pk):
    user = User.objects.get(id=pk)
    serializer = user_serializer(user, many=False)
    a = serializer.data
    a["avatar"] = Avatar.objects.get(id=serializer.data["avatar"]).avatar_url
    a["theme_preference"] = Theme.objects.get(
        id=serializer.data["theme_preference"]).name
    return Response(a)


@api_view(['POST'])
def insert_user(request):
    data = request.data
    
    if "avatar" in data:
        avatar = Avatar.objects.get(id=int(data['avatar']))
    else:
        avatar = Avatar.objects.get(id=1)
    user = User.objects.create(
        email=data['email'],
        bank_balance=data['bank_balance'],
        avatar = avatar,
        theme_preference=Theme.objects.get(name=data['theme_preference']),
        name=data['name'],
        monthly_target_saving=float(data['monthly_target_saving']),
    )
    if "pin_code" in data:
        if data["pin_code"] == "None" or data["pin_code"] == "null":
            user.pin_code = None
        else:
            user.pin_code = int(data['pin_code'])
    serializer = user_serializer(user, many=False)
    a = serializer.data
    a["avatar"] = Avatar.objects.get(id=serializer.data["avatar"]).avatar_url
    a["theme_preference"] = Theme.objects.get(
        id=serializer.data["theme_preference"]).name
    return Response(a)


@api_view(['POST'])
def is_available(request):
    data = request.data
    try:
        user = User.objects.get(
            email=data['email'],
        )
        serializer = user_serializer(user, many=False)
        a = serializer.data
        a["avatar"] = Avatar.objects.get(
            id=serializer.data["avatar"]).avatar_url
        a["theme_preference"] = Theme.objects.get(
            id=serializer.data["theme_preference"]).name
        return Response(a)
    except:
        return Response("false")


@api_view(['GET'])
def ananymous_login(request):
    user = User.objects.create(
        bank_balance=0,
        is_deactivated=True,
        theme_preference=Theme.objects.get(id=1),
        avatar=Avatar.objects.get(id=1),
        name="Ananymous",
        monthly_target_saving=0
    )
    serializer = user_serializer(user, many=False)
    a = serializer.data
    a["avatar"] = Avatar.objects.get(id=serializer.data["avatar"]).avatar_url
    a["theme_preference"] = Theme.objects.get(
        id=serializer.data["theme_preference"]).name
    return Response(a)


@api_view(['PUT'])
def update_user(request, pk):
    user = User.objects.get(id=pk)
    data = request.data
    if "email" in data:
        try:
            user.email = User.objects.get(email=data['email'])
            return HttpResponseNotFound("hello")
        except:
            user.email = data['email']
    if "theme_preference" in data:
        user.theme_preference = Theme.objects.get(
            name=data['theme_preference'])
    if "avatar" in data:
        user.avatar = Avatar.objects.get(id=int(data['avatar']))
    if "pin_code" in data:
        if data["pin_code"] == "None":
            user.pin_code = None
        else:
            user.pin_code = int(data['pin_code'])
    if "name" in data:
        user.name = data['name']
    if "is_deactivated" in data:
        user.is_deactivated = data['is_deactivated']
    if "monthly_target_saving" in data:
        user.monthly_target_saving = float(data['monthly_target_saving'])
    user.save()

    user = User.objects.get(id=pk)
    serializer = user_serializer(user, many=False)
    a = serializer.data
    a["avatar"] = Avatar.objects.get(id=serializer.data["avatar"]).avatar_url
    a["theme_preference"] = Theme.objects.get(
        id=serializer.data["theme_preference"]).name
    return Response(a)


@api_view(['DELETE'])
def delete_user(request, pk):
    user = User.objects.get(id=pk)
    user.delete()
    return Response('user was deleted!')
