from rest_framework.serializers import ModelSerializer
from .models import Diary

class DiarySerializer(ModelSerializer):
    class Meta:
        model = Diary
        fields = '__all__'