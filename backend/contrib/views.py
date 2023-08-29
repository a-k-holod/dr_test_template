from django.http import JsonResponse
from rest_framework import viewsets
from .models import Product
from .serializers import ProductSerializer


def char_count(request):
    text = request.GET.get("text", "")

    return JsonResponse({"count": len(text)})

class ProductViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer