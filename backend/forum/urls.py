from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

router = DefaultRouter()
router.register(r'forums', views.ForumViewSet)
router.register(r'memberships', views.ForumMembershipViewSet)
router.register(r'posts', views.PostViewSet)
router.register(r'images', views.PostImageViewSet)
router.register(r'links', views.PostLinkViewSet)
router.register(r'comments', views.CommentViewSet)

app_name = "forums"
urlpatterns = [
	path('', include(router.urls)),
]
