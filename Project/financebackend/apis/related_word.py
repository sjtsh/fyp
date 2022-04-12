from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from financebackend.models import *

from financebackend.serializers import related_word_serializer


@api_view(['GET'])
def get_related_words(request, pk):
    user = User.objects.get(id=pk)
    categories = Category.objects.all().filter(user=user)
    returnable = []
    for i in categories:
        related_words = RelatedWord.objects.all().filter(category=i)
        serializer = related_word_serializer(related_words, many=True)
        for i in serializer.data:
            if not i["is_deactivated"]:
                i.pop("is_deactivated")
                i.pop("date_time")
                i.pop("id")
                i.pop("impact")
                returnable.append(i)
    return Response(returnable)


@api_view(['GET'])
def get_related_word(request, pk):
    related_word = RelatedWord.objects.get(id=pk)
    serializer = related_word_serializer(related_word, many=False)
    return Response(serializer.data)


@api_view(['POST'])
def insert_related_word(request):
    data = request.data
    related_word = RelatedWord.objects.create(
        body=data['body']
    )
    serializer = related_word_serializer(related_word, many=False)
    return Response(serializer.data)


@api_view(['PUT'])
def update_related_word(request, pk):
    related_word = RelatedWord.objects.get(id=pk)
    serializer = related_word_serializer(related_word, data=request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)


@api_view(['DELETE'])
def delete_related_word(request, pk):
    related_word = RelatedWord.objects.get(id=pk)
    related_word.delete()
    return Response('related_word was deleted!')
