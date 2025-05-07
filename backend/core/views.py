from django.db.transaction import atomic
from rest_framework import viewsets, status, filters
from rest_framework.decorators import api_view, action
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response

from api.pagination import CustomPagination
from .models import (
	UserProfile, Subject, TutorProfile, StudentProfile,
	Notification, Review
)
from .serializers import (
	UserProfileSerializer, SubjectSerializer,
	TutorProfileSerializer, StudentProfileSerializer,
	NotificationSerializer,
	AvatarProfileSerializer, UserSerializer, ReviewSerializer
)


class SubjectViewSet(viewsets.ModelViewSet):
	queryset = Subject.objects.all()
	serializer_class = SubjectSerializer
	permission_classes = [AllowAny]
	pagination_class = CustomPagination
	filter_backends = [filters.SearchFilter]
	search_fields = ['name', 'description']


class UserProfileViewSet(viewsets.ModelViewSet):
	queryset = UserProfile.objects.order_by('-id')
	serializer_class = UserProfileSerializer
	permission_classes = [IsAuthenticated, ]
	pagination_class = CustomPagination

	@atomic
	def partial_update(self, request, *args, **kwargs):
		instance: UserProfile = self.queryset.get(pk=kwargs.get('pk'))

		user_data = request.data.pop('user', None)
		if user_data:
			user_serializer = UserSerializer(instance=instance.user, data=user_data, partial=True)
			if not user_serializer.is_valid():
				return Response({'user': user_serializer.errors}, status=status.HTTP_400_BAD_REQUEST)
			user_serializer.save()

		serializer = self.get_serializer(instance, data=request.data, partial=True)
		serializer.is_valid(raise_exception=True)
		serializer.save()
		return Response(UserProfileSerializer(instance).data, status=status.HTTP_200_OK)


class TutorProfileViewSet(viewsets.ModelViewSet):
	queryset = TutorProfile.objects.all()
	serializer_class = TutorProfileSerializer
	permission_classes = [IsAuthenticated]
	pagination_class = CustomPagination
	filter_backends = [filters.SearchFilter]
	search_fields = [
		'user_profile__user__first_name',
		'user_profile__user__last_name',
		'subjects__name',
		'qualifications'
	]

	def get_queryset(self):
		queryset = TutorProfile.objects.all()

		# Filter by subject
		subject = self.request.query_params.get('subject', None)
		if subject:
			queryset = queryset.filter(subjects__name__icontains=subject)

		# Filter by price range
		min_price = self.request.query_params.get('min_price', None)
		max_price = self.request.query_params.get('max_price', None)
		if min_price:
			queryset = queryset.filter(hourly_rate__gte=min_price)
		if max_price:
			queryset = queryset.filter(hourly_rate__lte=max_price)

		# Filter by availability
		is_available = self.request.query_params.get('is_available', None)
		if is_available:
			queryset = queryset.filter(is_available=True)

		return queryset.distinct()

	def get_my_profile(self):
		return TutorProfile.objects.filter(user_profile__user=self.request.user).first()

	@action(detail=False, methods=['get'])
	def me(self, request):
		profile = self.get_my_profile()
		if not profile:
			return Response(
				{'detail': 'Tutor profile not found.'},
				status=status.HTTP_404_NOT_FOUND
			)
		serializer = self.get_serializer(profile)
		return Response(serializer.data)

	@action(detail=False, methods=['patch'])
	def update_availability(self, request):
		profile = self.get_my_profile()
		if not profile:
			return Response(
				{'detail': 'Tutor profile not found.'},
				status=status.HTTP_404_NOT_FOUND
			)

		availability = request.data.get('availability')
		is_available = request.data.get('is_available')

		if availability is not None:
			profile.availability = availability
		if is_available is not None:
			profile.is_available = is_available

		profile.save()
		serializer = self.get_serializer(profile)
		return Response(serializer.data)


class StudentProfileViewSet(viewsets.ModelViewSet):
	queryset = StudentProfile.objects.all()
	serializer_class = StudentProfileSerializer
	permission_classes = [IsAuthenticated]
	pagination_class = CustomPagination

	def get_queryset(self):
		return StudentProfile.objects.filter(user_profile__user=self.request.user)

	def get_my_profile(self):
		return StudentProfile.objects.filter(user_profile__user=self.request.user).first()

	@action(detail=False, methods=['get'])
	def me(self, request):
		profile = self.get_my_profile()
		if not profile:
			return Response(
				{'detail': 'Student profile not found.'},
				status=status.HTTP_404_NOT_FOUND
			)
		serializer = self.get_serializer(profile)
		return Response(serializer.data)


class ReviewsViewSet(viewsets.ModelViewSet):
	serializer_class = ReviewSerializer
	permission_classes = [IsAuthenticated]
	pagination_class = CustomPagination
	queryset = Review.objects.order_by('-id')


class NotificationViewSet(viewsets.ModelViewSet):
	serializer_class = NotificationSerializer
	permission_classes = [IsAuthenticated]
	pagination_class = CustomPagination

	def get_queryset(self):
		return Notification.objects.filter(
			recipient=self.request.user
		).order_by('-created_at')

	@action(detail=True, methods=['patch'])
	def mark_as_read(self, request, pk=None):
		try:
			notification = Notification.objects.get(pk=pk, recipient=request.user)
			notification.is_read = True
			notification.save()
			serializer = self.get_serializer(notification)
			return Response(serializer.data)
		except Notification.DoesNotExist:
			return Response({'detail': 'Notification not found or does not belong to the user.'}, status=404)

	@action(detail=False, methods=['patch'])
	def mark_all_as_read(self, request):
		self.get_queryset().update(is_read=True)
		return Response({'detail': 'All notifications marked as read'})

	@action(detail=False, methods=['get'])
	def unread_count(self, request):
		count = self.get_queryset().filter(is_read=False).count()
		return Response({'unread_count': count})


@api_view(["GET"])
def avatar(request):
	if hasattr(request.user, 'profile'):
		return Response(
			AvatarProfileSerializer(
				instance=request.user.profile
			).data, status=status.HTTP_200_OK
		)
	return Response({
		'detail': "User has no associated profile.",
	}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
