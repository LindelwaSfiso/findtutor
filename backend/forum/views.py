from rest_framework import viewsets, status, permissions
from rest_framework.decorators import action
from rest_framework.response import Response
from django.shortcuts import get_object_or_404
from .models import Forum, ForumMembership, Post, PostImage, PostLink, Comment
from .serializers import (
	ForumSerializer, ForumMembershipSerializer, PostSerializer,
	PostImageSerializer, PostLinkSerializer, CommentSerializer
)
from api.pagination import CustomPagination


class IsForumAdminOrReadOnly(permissions.BasePermission):
	def has_object_permission(self, request, view, obj):
		if request.method in permissions.SAFE_METHODS:
			return True
		return obj.admin == request.user.profile


class IsPostAuthorOrReadOnly(permissions.BasePermission):
	def has_object_permission(self, request, view, obj):
		if request.method in permissions.SAFE_METHODS:
			return True
		return obj.author == request.user.profile


class IsCommentAuthorOrReadOnly(permissions.BasePermission):
	def has_object_permission(self, request, view, obj):
		if request.method in permissions.SAFE_METHODS:
			return True
		return obj.author == request.user.profile


class ForumViewSet(viewsets.ModelViewSet):
	queryset = Forum.objects.all()
	serializer_class = ForumSerializer
	pagination_class = CustomPagination
	permission_classes = [permissions.IsAuthenticatedOrReadOnly, IsForumAdminOrReadOnly]

	def perform_create(self, serializer):
		serializer.save(admin=self.request.user.profile)

	@action(detail=True, methods=['post'])
	def join(self, request, pk=None):
		forum = self.get_object()
		user = request.user.profile

		if forum.is_private:
			membership, created = ForumMembership.objects.get_or_create(
				user=user,
				forum=forum,
				defaults={'status': 'pending'}
			)
			return Response({'status': 'Join request sent'})
		else:
			membership, created = ForumMembership.objects.get_or_create(
				user=user,
				forum=forum,
				defaults={'status': 'approved'}
			)
			return Response({'status': 'Joined forum successfully'})

	@action(detail=True, methods=['post'])
	def leave(self, request, pk=None):
		forum = self.get_object()
		ForumMembership.objects.filter(
			user=request.user.profile,
			forum=forum
		).delete()
		return Response({'status': 'Left forum successfully'})

	@action(detail=True, methods=['post'])
	def follow(self, request, pk=None):
		forum = self.get_object()
		forum.followers.add(request.user.profile)
		return Response({'status': 'Following forum'})

	@action(detail=True, methods=['post'])
	def unfollow(self, request, pk=None):
		forum = self.get_object()
		forum.followers.remove(request.user.profile)
		return Response({'status': 'Unfollowed forum'})


class ForumMembershipViewSet(viewsets.ModelViewSet):
	queryset = ForumMembership.objects.all()
	serializer_class = ForumMembershipSerializer
	permission_classes = [permissions.IsAuthenticated]

	def get_queryset(self):
		if self.action == 'list':
			return ForumMembership.objects.filter(forum__admin=self.request.user.profile)
		return ForumMembership.objects.all()

	@action(detail=True, methods=['post'])
	def approve(self, request, pk=None):
		membership = self.get_object()
		if membership.forum.admin == request.user.profile:
			membership.status = 'approved'
			membership.save()
			return Response({'status': 'Membership approved'})
		return Response(
			{'error': 'Only forum admin can approve memberships'},
			status=status.HTTP_403_FORBIDDEN
		)

	@action(detail=True, methods=['post'])
	def reject(self, request, pk=None):
		membership = self.get_object()
		if membership.forum.admin == request.user.profile:
			membership.status = 'rejected'
			membership.save()
			return Response({'status': 'Membership rejected'})
		return Response(
			{'error': 'Only forum admin can reject memberships'},
			status=status.HTTP_403_FORBIDDEN
		)


class PostViewSet(viewsets.ModelViewSet):
	queryset = Post.objects.all()
	serializer_class = PostSerializer
	permission_classes = [permissions.IsAuthenticatedOrReadOnly, IsPostAuthorOrReadOnly]

	def perform_create(self, serializer):
		serializer.save(author=self.request.user.profile)

	@action(detail=True, methods=['post'])
	def like(self, request, pk=None):
		post = self.get_object()
		post.likes.add(request.user.profile)
		return Response({'status': 'Post liked'})

	@action(detail=True, methods=['post'])
	def unlike(self, request, pk=None):
		post = self.get_object()
		post.likes.remove(request.user.profile)
		return Response({'status': 'Post unliked'})


class PostImageViewSet(viewsets.ModelViewSet):
	queryset = PostImage.objects.all()
	serializer_class = PostImageSerializer
	permission_classes = [permissions.IsAuthenticated]

	def perform_create(self, serializer):
		post = get_object_or_404(Post, pk=self.request.data.get('post'))
		if post.author == self.request.user.profile:
			serializer.save()
		else:
			raise permissions.PermissionDenied("You can only add images to your own posts")


class PostLinkViewSet(viewsets.ModelViewSet):
	queryset = PostLink.objects.all()
	serializer_class = PostLinkSerializer
	permission_classes = [permissions.IsAuthenticated]

	def perform_create(self, serializer):
		post = get_object_or_404(Post, pk=self.request.data.get('post'))
		if post.author == self.request.user.profile:
			serializer.save()
		else:
			raise permissions.PermissionDenied("You can only add links to your own posts")


class CommentViewSet(viewsets.ModelViewSet):
	queryset = Comment.objects.all()
	serializer_class = CommentSerializer
	permission_classes = [permissions.IsAuthenticatedOrReadOnly, IsCommentAuthorOrReadOnly]

	def perform_create(self, serializer):
		serializer.save(author=self.request.user.profile)

	@action(detail=True, methods=['post'])
	def like(self, request, pk=None):
		comment = self.get_object()
		comment.likes.add(request.user.profile)
		return Response({'status': 'Comment liked'})

	@action(detail=True, methods=['post'])
	def unlike(self, request, pk=None):
		comment = self.get_object()
		comment.likes.remove(request.user.profile)
		return Response({'status': 'Comment unliked'})
