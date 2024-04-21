from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Diary
from .serializers import DiarySerializer
from rest_framework.generics import (CreateAPIView ,
                                     UpdateAPIView,
                                     DestroyAPIView,
                                     ListAPIView,
                                     RetrieveUpdateDestroyAPIView,
                                     ListCreateAPIView
                                     )


@api_view(["POST"])
def createEntry(request):
    data=request.data.dict()
    print(data)
    serializer=DiarySerializer(data=data)
    if serializer.is_valid(raise_exception=True):
        entry=serializer.save()
        return Response(DiarySerializer(entry,many=False).data)
    return Response({})

class CreateEntryAPI(CreateAPIView):
    # queryset = None
    serializer_class = DiarySerializer

class DiaryAPI(ListCreateAPIView):
    serializer_class=DiarySerializer
    queryset = Diary.objects.all()

    def get_queryset(self):
        queryset=Diary.objects.all()
        return queryset

class DiaryRetrieveUpdateDestroyAPIView(RetrieveUpdateDestroyAPIView):
    serializer_class = DiarySerializer
    queryset = Diary.objects.all()
    lookup_field = 'pk'
    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = DiarySerializer(instance)
        return Response(serializer.data)

    def update(self, request, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        instance=serializer.save()
        serializer = DiarySerializer(instance)

        if getattr(instance, '_prefetched_objects_cache', None):
            # If 'prefetch_related' has been applied to a queryset, we need to
            # forcibly invalidate the prefetch cache on the instance.
            instance._prefetched_objects_cache = {}

        return Response(serializer.data)



def getEntry(request):
    pass
def getListOfEntries(request):
    pass
def updateEntry(request):
    pass

def deleteEntry(request):
    pass