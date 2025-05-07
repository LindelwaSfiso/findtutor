from django.urls import path, include
from rest_framework.routers import DefaultRouter

from .views import (
	SubjectViewSet, UserProfileViewSet, TutorProfileViewSet,
	StudentProfileViewSet, ReviewsViewSet,
	NotificationViewSet, avatar
)

router = DefaultRouter()
router.register(r'subjects', SubjectViewSet, basename='subjects')
router.register(r'profiles', UserProfileViewSet, basename='profiles')
router.register(r'tutors', TutorProfileViewSet, basename='tutors')
router.register(r'students', StudentProfileViewSet, basename='students')
router.register(r'reviews', ReviewsViewSet, basename='reviews')
router.register(r'notifications', NotificationViewSet, basename='notifications')

app_name = "core"
urlpatterns = [
	path('', include(router.urls)),
	path('avatar/', avatar),
	path('dashboard/', TutorProfileViewSet.as_view(
		actions={'get': 'list'}
	)),
]
