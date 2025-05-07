import os
import django

# Set the settings module
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'findtutor.settings')

# Initialize Django
django.setup()


from django.contrib.auth.models import User

# Update with your desired superuser credentials
username = "admin"
email = "sfisolindelwa@gmail.com"
password = "*******"

if not User.objects.filter(username=username).exists():
    User.objects.create_superuser(username=username, email=email, password=password)
    print("Superuser created successfully!")
else:
    print("Superuser already exists!")

