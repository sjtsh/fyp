from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from financebackend.models import Theme

from financebackend.serializers import theme_serializer

@api_view(['GET'])
def get_themes(request):
    themes = Theme.objects.all()
    serializer = theme_serializer(themes, many = True)
    return Response(serializer.data)


@api_view(['GET'])
def get_theme(request, pk):
    theme = Theme.objects.get(id=pk)
    serializer = theme_serializer(theme, many = False)
    return Response(serializer.data)

@api_view(['POST'])
def insert_theme(request):
    data = request.data
    theme = Theme.objects.create(
        body = data['body']
    )
    serializer = theme_serializer(theme, many = False)
    return Response(serializer.data)
    
@api_view(['PUT'])
def update_theme(request, pk):
    theme = Theme.objects.get(id=pk)
    serializer = theme_serializer(theme, data = request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)

@api_view(['DELETE'])
def delete_theme(request, pk):
    theme = Theme.objects.get(id=pk)
    theme.delete()
    return Response('theme was deleted!')