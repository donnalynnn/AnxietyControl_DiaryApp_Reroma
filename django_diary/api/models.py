from django.db import models

class Diary(models.Model):
    title = models.TextField(max_length=60,null=False)
    body = models.TextField(max_length=5000)
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.title[0:40]
    
    class Meta: 
        ordering = ['-updated']