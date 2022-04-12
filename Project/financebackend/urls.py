from django.urls import path
from financebackend.apis.categories import *
from financebackend.apis.gender import *
from financebackend.apis.theme import *
from financebackend.apis.avatar import *
from financebackend.apis.related_word import *
from financebackend.apis.user import *
from financebackend.apis.transaction import *
from financebackend.apis.correction import *
from financebackend.apis.linear import *

from . import views

urlpatterns = [
    path('', views.getRoutes),
    path('linearmodel/<str:pk>/', predict_user_expenses),
    path('linearmodel/<str:pk>/train/', train_user_expenses),
    path('radar/<int:pk>/', radar),


    # category
    path('categorys/', get_categorys_with_amounts),
    path('category/insert/', insert_category),
    path('category/<str:pk>/update/', update_category),
    path('category/<str:pk>/delete/', delete_category),
    path('categorys/<int:pk>/', get_category),

    # gender
    path('genders/', get_genders),
    path('gender/insert/', insert_gender),
    path('gender/<str:pk>/update/', update_gender),
    path('gender/<str:pk>/delete/', delete_gender),
    path('genders/<int:pk>/', get_gender),

    # themes
    path('themes/', get_themes),
    path('theme/insert/', insert_theme),
    path('theme/<str:pk>/update/', update_theme),
    path('theme/<str:pk>/delete/', delete_theme),
    path('themes/<int:pk>/', get_theme),

    # avatar
    path('avatars/', get_avatars),
    path('avatar/insert/', insert_avatar),
    path('avatar/<str:pk>/update/', update_avatar),
    path('avatar/<str:pk>/delete/', delete_avatar),
    path('avatars/<int:pk>/', get_avatar),

    # related word
    path('relatedwords/<str:pk>/', get_related_words),
    path('relatedword/insert/', insert_related_word),
    path('relatedword/<str:pk>/update/', update_related_word),
    path('relatedword/<str:pk>/delete/', delete_related_word),
    path('relatedwords/', get_related_word),

    # user
    path('users/', get_users),
    path('users/insert/', insert_user),
    path('user/<int:pk>/update/', update_user),
    path('user/<int:pk>/delete/', delete_user),
    path('users/<int:pk>/', get_user),
    path('users/ananymous/', ananymous_login),
    path('users/available/', is_available),

    # transaction
    path('transactions/', get_transactions_by_time),
    path('transaction/insert/', insert_transaction),
    path('transaction/<str:pk>/update/', update_transaction),
    path('transaction/<str:pk>/delete/', delete_transaction),
    path('transactions/<int:pk>/', get_transaction),

    # correction
    path('corrections/', get_corrections),
    path('correction/insert/', insert_correction),
    path('correction/<str:pk>/update/', update_correction),
    path('correction/<str:pk>/delete/', delete_correction),
    path('corrections/<int:pk>/', get_correction),
]
