from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from financebackend.models import Gender

from financebackend.serializers import gender_serializer

@api_view(['GET'])
def get_genders(request):
    genders = Gender.objects.all()
    serializer = gender_serializer(genders, many = True)
    return Response(serializer.data)


@api_view(['GET'])
def get_gender(request, pk):
    gender = Gender.objects.get(id=pk)
    serializer = gender_serializer(gender, many = False)
    return Response(serializer.data)

@api_view(['POST'])
def insert_gender(request):
    data = request.data
    gender = Gender.objects.create(
        body = data['body']
    )
    serializer = gender_serializer(gender, many = False)
    return Response(serializer.data)
    
@api_view(['PUT'])
def update_gender(request, pk):
    gender = Gender.objects.get(id=pk)
    serializer = gender_serializer(gender, data = request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)

@api_view(['DELETE'])
def delete_gender(request, pk):
    gender = Gender.objects.get(id=pk)
    gender.delete()
    return Response('gender was deleted!')