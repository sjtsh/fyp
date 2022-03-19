from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from financebackend.models import Correction, User

from financebackend.serializers import correction_serializer

@api_view(['GET'])
def get_corrections(request):
    corrections = Correction.objects.all()
    serializer = correction_serializer(corrections, many = True)
    return Response(serializer.data)


@api_view(['GET'])
def get_correction(request, pk):
    correction = Correction.objects.get(id=pk)
    serializer = correction_serializer(correction, many = False)
    return Response(serializer.data)

@api_view(['POST'])
def insert_correction(request):
    data = request.data
    correction = Correction.objects.create(
        user = User.objects.get(id = int(data['user'])),
        correction = float(data['correction']),
        remark = data['remark']
    )
    serializer = correction_serializer(correction, many = False)
    user = User.objects.get(id = data['user'])
    user.bank_balance += float(data['correction'])
    user.save()
    return Response(serializer.data)
    
@api_view(['PUT'])
def update_correction(request, pk):
    correction = Correction.objects.get(id=pk)
    serializer = correction_serializer(correction, data = request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)

@api_view(['DELETE'])
def delete_correction(request, pk):
    correction = Correction.objects.get(id=pk)
    correction.delete()
    return Response('correction was deleted!')