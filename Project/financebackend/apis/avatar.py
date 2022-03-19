from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from financebackend.models import Avatar, Gender

from financebackend.serializers import avatar_serializer

@api_view(['GET'])
def get_avatars(request):
    avatar = Avatar.objects.all()
    serializer = avatar_serializer(avatar, many = True)
    for i in serializer.data:
        i["gender"] = Gender.objects.get(id = i["gender"]).name
    return Response(serializer.data)


@api_view(['GET'])
def get_avatar(request, pk):
    avatars = Avatar.objects.get(id=pk)
    serializer = avatar_serializer(avatars, many = False)
    a = serializer.data
    a["gender"] = Gender.objects.get(id = serializer.data["gender"]).name
    return Response(serializer.data)

@api_view(['POST'])
def insert_avatar(request):
    data = request.data
    avatar = Avatar.objects.create(
        body = data['body']
    )
    serializer = avatar_serializer(avatar, many = False)
    return Response(serializer.data)
    
@api_view(['PUT'])
def update_avatar(request, pk):
    avatar = Avatar.objects.get(id=pk)
    serializer = avatar_serializer(avatar, data = request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)

@api_view(['DELETE'])
def delete_avatar(request, pk):
    avatar = Avatar.objects.get(id=pk)
    avatar.delete()
    return Response('avatar was deleted!')