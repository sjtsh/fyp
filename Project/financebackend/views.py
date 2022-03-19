from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import *

# @api_view(['GET', 'POST', 'DELETE'])
@api_view(['GET'])
def getRoutes(request):
    routes = [
        {
            'Endpoint' : '/categorys',
            'method' : 'GET',
            'body' : None,
            'description' : 'Returns all categories'
        },
        {
            'Endpoint' : '/categorys/id',
            'method' : 'GET',
            'body' : None,
            'description' : 'Returns a single category object'
        },
        {
            'Endpoint' : '/category/create/',
            'method' : 'POST',
            'body' : {'body':''},
            'description' : 'Inserts a new category'
        },
        {
            'Endpoint' : '/category/id/update/',
            'method' : 'PUT',
            'body' : {'body':''},
            'description' : 'Updates a existing category'
        },
        {
            'Endpoint' : '/category/id/delete/',
            'method' : 'DELETE',
            'body' : None,
            'description' : 'Deletes a existing category'
        }
    ]
    return Response(routes)