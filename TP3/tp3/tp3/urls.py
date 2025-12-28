from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("", include("bonnes_lectures.urls"))
    # path('admin/', admin.site.urls),
]
