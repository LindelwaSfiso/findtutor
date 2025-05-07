from rest_framework import generics
from rest_framework.permissions import AllowAny

from core.serializers import UserProfileSerializer
from core.models import UserProfile


class SignUpUserView(generics.CreateAPIView):
	serializer_class = UserProfileSerializer
	queryset = UserProfile.objects.all()
	permission_classes = [AllowAny, ]
