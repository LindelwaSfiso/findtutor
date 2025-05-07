from rest_framework import serializers
from .models import Forum, ForumMembership, Post, PostImage, PostLink, Comment
from core.serializers import UserProfileSerializer


class ForumMembershipSerializer(serializers.ModelSerializer):
	user = UserProfileSerializer(read_only=True)

	class Meta:
		model = ForumMembership
		fields = ['id', 'user', 'forum', 'status', 'joined_at', 'updated_at']
		read_only_fields = ['joined_at', 'updated_at']


class PostImageSerializer(serializers.ModelSerializer):
	class Meta:
		model = PostImage
		fields = ['id', 'image', 'caption', 'uploaded_at']
		read_only_fields = ['uploaded_at']


class PostLinkSerializer(serializers.ModelSerializer):
	class Meta:
		model = PostLink
		fields = ['id', 'url', 'title', 'description', 'added_at']
		read_only_fields = ['added_at']


class CommentSerializer(serializers.ModelSerializer):
	author = UserProfileSerializer(read_only=True)
	likes_count = serializers.SerializerMethodField()
	replies = serializers.SerializerMethodField()

	class Meta:
		model = Comment
		fields = ['id', 'post', 'author', 'content', 'parent', 'created_at', 'updated_at', 'likes_count', 'replies']
		read_only_fields = ['created_at', 'updated_at']

	def get_likes_count(self, obj):
		return obj.likes.count()

	def get_replies(self, obj):
		if obj.parent is None:  # Only get replies for parent comments
			replies = Comment.objects.filter(parent=obj)
			return CommentSerializer(replies, many=True).data
		return []


class PostSerializer(serializers.ModelSerializer):
	author = UserProfileSerializer(read_only=True)
	images = PostImageSerializer(many=True, read_only=True)
	links = PostLinkSerializer(many=True, read_only=True)
	comments = serializers.SerializerMethodField()
	likes_count = serializers.SerializerMethodField()

	class Meta:
		model = Post
		fields = ['id', 'forum', 'author', 'title', 'content', 'post_type', 'created_at',
				  'updated_at', 'images', 'links', 'comments', 'likes_count']
		read_only_fields = ['created_at', 'updated_at']

	def get_comments(self, obj):
		# Only get parent comments (no replies)
		comments = obj.comments.filter(parent=None)
		return CommentSerializer(comments, many=True).data

	def get_likes_count(self, obj):
		return obj.likes.count()


class ForumSerializer(serializers.ModelSerializer):
	admin = UserProfileSerializer(read_only=True)
	members_count = serializers.SerializerMethodField()
	followers_count = serializers.SerializerMethodField()
	posts_count = serializers.SerializerMethodField()
	latest_posts = serializers.SerializerMethodField()

	class Meta:
		model = Forum
		fields = ['id', 'name', 'description', 'admin', 'is_private', 'created_at',
				  'updated_at', 'members_count', 'followers_count', 'posts_count', 'latest_posts']
		read_only_fields = ['created_at', 'updated_at']

	def get_members_count(self, obj):
		return obj.members.filter(forummembership__status='approved').count()

	def get_followers_count(self, obj):
		return obj.followers.count()

	def get_posts_count(self, obj):
		return obj.posts.count()

	def get_latest_posts(self, obj):
		latest_posts = obj.posts.all()[:5]  # Get 5 latest posts
		return PostSerializer(latest_posts, many=True).data
