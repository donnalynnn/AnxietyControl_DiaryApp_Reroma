from django.urls import path
from . import views

urlpatterns = [
    # path('',views.getRoutes),
    path('diaryapp/getListOfEntries/', views.DiaryAPI.as_view()),
    path('diaryapp/create/', views.CreateEntryAPI.as_view()),
    path('diaryapp/<str:pk>/deleteUpdateEntry/', views.DiaryRetrieveUpdateDestroyAPIView.as_view()),
    path('diaryapp/delete/', views.deleteEntry),
    path('diaryapp/<str:pk>/', views.getEntry),
    
]