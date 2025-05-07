from django.contrib import admin
from .models import (
	UserProfile, Subject, TutorProfile,
	StudentProfile, Review
)


@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
	list_display = ('user', 'user_type', 'city', 'phone_number')
	list_filter = ('user_type', 'city')
	search_fields = ('user__username', 'user__email', 'user__first_name', 'user__last_name')
	list_per_page = 50


@admin.register(Subject)
class SubjectAdmin(admin.ModelAdmin):
	list_display = ('name', 'description')
	search_fields = ('name', 'description')
	list_per_page = 50


@admin.register(TutorProfile)
class TutorProfileAdmin(admin.ModelAdmin):
	list_display = ('user_profile', 'education_level', 'experience_years', 'hourly_rate', 'is_available')
	list_filter = ('education_level', 'is_available')
	search_fields = (
		'user_profile__user__username',
		'user_profile__user__email',
		'user_profile__user__first_name',
		'user_profile__user__last_name',
		'qualifications'
	)
	list_per_page = 50


@admin.register(StudentProfile)
class StudentProfileAdmin(admin.ModelAdmin):
	list_display = ('user_profile', 'education_level', 'grade_level', 'school_name')
	list_filter = ('education_level',)
	search_fields = (
		'user_profile__user__username',
		'user_profile__user__email',
		'user_profile__user__first_name',
		'user_profile__user__last_name',
		'school_name'
	)
	list_per_page = 50


@admin.register(Review)
class ReviewAdmin(admin.ModelAdmin):
	list_display = ('tutor_profile', 'user_profile', 'rating', 'created_at')
	list_filter = ('rating',)
	search_fields = (
		'tutor_profile__user_profile__user__username',
		'user_profile__user__username',
		'comment'
	)
	list_per_page = 50