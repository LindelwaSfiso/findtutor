from rest_framework import serializers
from django.db.transaction import atomic
from django.contrib.auth.models import User
from .models import (
	UserProfile, Subject, TutorProfile, StudentProfile,
	Review, Notification
)


class UserSerializer(serializers.ModelSerializer):
	class Meta:
		model = User
		fields = ['id', 'username', 'email', 'first_name', 'last_name', 'password']
		extra_kwargs = {
			'password': {'write_only': True, 'required': True}
		}

	def create(self, validated_data):
		return User.objects.create_user(**validated_data)


class AvatarProfileSerializer(serializers.ModelSerializer):
	class AvatarUserSerializer(serializers.ModelSerializer):
		class Meta:
			model = User
			fields = ["id", "username", "first_name", "last_name", "email"]

	user = AvatarUserSerializer(many=False, read_only=True)

	class Meta:
		model = UserProfile
		fields = ['id', 'profile_pic', 'bio', 'user']


class UserProfileSerializer(serializers.ModelSerializer):
	user = UserSerializer(many=False)

	class Meta:
		model = UserProfile
		fields = '__all__'

	@atomic
	def create(self, validated_data):
		user_data = validated_data.pop('user')
		user = User.objects.create_user(**user_data)
		return UserProfile.objects.create(user=user, **validated_data)


class SubjectSerializer(serializers.ModelSerializer):
	class Meta:
		model = Subject
		fields = ['id', 'name', 'description']


class TutorProfileSerializer(serializers.ModelSerializer):
	user_profile = UserProfileSerializer(read_only=True)
	subjects = SubjectSerializer(many=True, read_only=True)
	subject_ids = serializers.PrimaryKeyRelatedField(
		queryset=Subject.objects.all(),
		write_only=True,
		many=True,
		required=False
	)

	class Meta:
		model = TutorProfile
		fields = '__all__'
		read_only_fields = ['id', 'is_verified']

	def create(self, validated_data):
		subject_ids = validated_data.pop('subject_ids', [])
		tutor_profile = TutorProfile.objects.create(**validated_data)
		if subject_ids:
			tutor_profile.subjects.set(subject_ids)
		return tutor_profile

	def update(self, instance, validated_data):
		subject_ids = validated_data.pop('subject_ids', None)
		for attr, value in validated_data.items():
			setattr(instance, attr, value)
		if subject_ids is not None:
			instance.subjects.set(subject_ids)
		instance.save()
		return instance


class StudentProfileSerializer(serializers.ModelSerializer):
	user_profile = UserProfileSerializer(read_only=True)
	subjects_of_interest = SubjectSerializer(many=True, read_only=True)
	subject_ids = serializers.PrimaryKeyRelatedField(
		queryset=Subject.objects.all(),
		many=True,
		write_only=True,
		required=False
	)

	class Meta:
		model = StudentProfile
		fields = [
			'id', 'user_profile', 'education_level',
			'subjects_of_interest', 'subject_ids',
			'grade_level', 'school_name'
		]

	def create(self, validated_data):
		subject_ids = validated_data.pop('subject_ids', [])
		student_profile = StudentProfile.objects.create(**validated_data)
		if subject_ids:
			student_profile.subjects_of_interest.set(subject_ids)
		return student_profile

	def update(self, instance, validated_data):
		subject_ids = validated_data.pop('subject_ids', None)
		for attr, value in validated_data.items():
			setattr(instance, attr, value)
		if subject_ids is not None:
			instance.subjects_of_interest.set(subject_ids)
		instance.save()
		return instance


class ReviewSerializer(serializers.ModelSerializer):
	class Meta:
		model = Review
		fields = '__all__'


class NotificationSerializer(serializers.ModelSerializer):
	class Meta:
		model = Notification
		fields = '__all__'


