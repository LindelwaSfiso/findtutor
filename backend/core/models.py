from django.db import models
from django.contrib.auth.models import User
from django.core.validators import MinValueValidator, MaxValueValidator
from django.db.models.signals import post_save
from django.dispatch import receiver


class UserProfile(models.Model):
	USER_TYPE_CHOICES = (
		('student', 'Student'),
		('tutor', 'Tutor'),
	)

	user = models.OneToOneField(User, on_delete=models.CASCADE, related_name="profile")
	user_type = models.CharField(max_length=10, choices=USER_TYPE_CHOICES, default='student')
	#
	phone_number = models.CharField(max_length=15, blank=True, null=True)
	city = models.CharField(max_length=100, blank=True, null=True)
	address = models.TextField(blank=True, null=True)
	profile_pic = models.ImageField(upload_to='pics/', default='pics/default.jpg')
	bio = models.TextField(blank=True, null=True)
	#
	created_at = models.DateTimeField(auto_now_add=True)
	updated_at = models.DateTimeField(auto_now=True)

	def __str__(self):
		return f"{self.user.get_full_name()} ({self.user_type})"


class Subject(models.Model):
	name = models.CharField(max_length=100)
	description = models.TextField(blank=True, null=True)

	def __str__(self):
		return self.name


class TutorProfile(models.Model):
	EDUCATION_LEVEL_CHOICES = (
		('high_school', 'High School'),
		('diploma', 'Diploma'),
		('bachelors', 'Bachelor\'s Degree'),
		('masters', 'Master\'s Degree'),
		('phd', 'PhD'),
	)

	user_profile = models.OneToOneField(UserProfile, on_delete=models.CASCADE, related_name='tutor_profile')
	subjects = models.ManyToManyField(Subject, related_name='tutors')
	education_level = models.CharField(max_length=20, choices=EDUCATION_LEVEL_CHOICES)
	qualifications = models.TextField()
	experience_years = models.PositiveIntegerField(default=0)
	hourly_rate = models.DecimalField(max_digits=10, decimal_places=2)
	availability = models.TextField()
	is_available = models.BooleanField(default=True)
	is_verified = models.BooleanField(
		default=False,
		help_text="Indicates if the tutor has been verified by administrators"
	)

	# Contact Details
	contact_email = models.EmailField(blank=True, null=True)
	contact_phone = models.CharField(max_length=15, blank=True, null=True)
	whatsapp_number = models.CharField(max_length=15, blank=True, null=True)
	website = models.URLField(blank=True, null=True)

	def __str__(self):
		return f"{self.user_profile.user.get_full_name()} - Tutor Profile"


class StudentProfile(models.Model):
	EDUCATION_LEVEL_CHOICES = (
		('primary', 'Primary School'),
		('high_school', 'High School'),
		('college', 'College'),
		('university', 'University'),
	)

	user_profile = models.OneToOneField(UserProfile, on_delete=models.CASCADE, related_name='student_profile')
	education_level = models.CharField(max_length=20, choices=EDUCATION_LEVEL_CHOICES)
	subjects_of_interest = models.ManyToManyField(Subject, related_name='interested_students')
	grade_level = models.CharField(max_length=50, blank=True, null=True)
	school_name = models.CharField(max_length=200, blank=True, null=True)

	def __str__(self):
		return f"{self.user_profile.user.get_full_name()} - Student Profile"


class Review(models.Model):
	tutor_profile = models.OneToOneField(TutorProfile, on_delete=models.CASCADE, related_name='reviews')
	user_profile = models.OneToOneField(UserProfile, on_delete=models.CASCADE, related_name='reviews')
	rating = models.PositiveIntegerField(validators=[MinValueValidator(1), MaxValueValidator(5)])
	comment = models.TextField()
	created_at = models.DateTimeField(auto_now_add=True)

	def __str__(self):
		return f"Review for {self.tutor_profile} by {self.user_profile}"


class Notification(models.Model):
	NOTIFICATION_TYPES = (
		('welcome', 'Welcome'),
		('new_review', 'New Review'),
		('profile_update', 'Profile Update'),
		('system', 'System'),
		('other', "Other")
	)

	recipient = models.ForeignKey(User, on_delete=models.CASCADE, related_name='notifications')
	notification_type = models.CharField(max_length=20, choices=NOTIFICATION_TYPES)
	title = models.CharField(max_length=200)
	message = models.TextField()
	is_read = models.BooleanField(default=False)
	created_at = models.DateTimeField(auto_now_add=True)
	related_object_id = models.PositiveIntegerField(null=True, blank=True)
	related_object_type = models.CharField(max_length=50, null=True, blank=True)

	class Meta:
		ordering = ['-created_at']

	def __str__(self):
		return f"{self.notification_type} - {self.recipient}"


@receiver(post_save, sender=UserProfile)
def create_user_profile(sender, instance, created, **kwargs):
	if created:
		if instance.user_type == 'student':
			StudentProfile.objects.create(user_profile=instance)
		elif instance.user_type == 'tutor':
			TutorProfile.objects.create(user_profile=instance)

		# Create welcome notification
		Notification.objects.create(
			recipient=instance.user,
			notification_type='welcome',
			title='Welcome to Find Tutor!',
			message=f"Welcome to Find Tutor, {instance.user.get_full_name()}! We're excited to have you on board. "
					f"Complete your profile to get started."
		)


@receiver(post_save, sender=TutorProfile)
def tutor_profile_updated(sender, instance, created, **kwargs):
	if not created:
		Notification.objects.create(
			recipient=instance.user_profile,
			notification_type='profile_update',
			title='Profile Updated',
			message='Your tutor profile has been updated successfully.'
		)


@receiver(post_save, sender=StudentProfile)
def student_profile_updated(sender, instance, created, **kwargs):
	if not created:
		Notification.objects.create(
			recipient=instance.user_profile,
			notification_type='profile_update',
			title='Profile Updated',
			message='Your student profile has been updated successfully.'
		)


@receiver(post_save, sender=Review)
def review_created(sender, instance, created, **kwargs):
	if created:
		# Notify tutor about new review
		Notification.objects.create(
			recipient=instance.tutor_profile.user_profile,
			notification_type='new_review',
			title='New Review Received',
			message=f'You have received a new {instance.rating}-star review from {instance.user_profile.user.get_full_name()}.'
		)
