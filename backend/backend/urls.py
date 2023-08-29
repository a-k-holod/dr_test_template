# from contrib.views import char_count
# from django.contrib import admin
# from django.urls import path, re_path, include
# from django.views.generic import TemplateView
#
# from rest_framework.routers import DefaultRouter
# from contrib.views import ProductViewSet
#
# router = DefaultRouter()
# router.register(r'products', ProductViewSet)
#
# urlpatterns = [
#     path("admin/", admin.site.urls),
#     path("char_count", char_count, name="char_count"),
#     re_path(".*", TemplateView.as_view(template_name="index.html")),
#     path('api/', include(router.urls)),
#
# ]

from contrib.views import char_count
from django.contrib import admin
from django.urls import path, re_path, include
from rest_framework.routers import DefaultRouter
from contrib.views import ProductViewSet
from django.views.generic import TemplateView

router = DefaultRouter()
router.register(r'products', ProductViewSet)

urlpatterns = [
    path("admin/", admin.site.urls),
    path("char_count", char_count, name="char_count"),
    path('api/', include(router.urls)),
    re_path(r'^.*$', TemplateView.as_view(template_name="index.html")),
]
