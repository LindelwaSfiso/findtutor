from django.contrib import admin
from .models import Forum, ForumMembership, Post, PostImage, PostLink, Comment


@admin.register(Forum)
class ForumAdmin(admin.ModelAdmin):
    list_display = ('name', 'admin', 'is_private', 'created_at')
    list_filter = ('is_private', 'created_at')
    search_fields = ('name', 'description', 'admin__user__username')
    list_per_page = 50


@admin.register(ForumMembership)
class ForumMembershipAdmin(admin.ModelAdmin):
    list_display = ('user', 'forum', 'status', 'joined_at')
    list_filter = ('status', 'joined_at')
    search_fields = ('user__user__username', 'forum__name')
    list_per_page = 50


@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display = ('title', 'forum', 'author', 'post_type', 'created_at')
    list_filter = ('post_type', 'created_at')
    search_fields = ('title', 'content', 'author__user__username', 'forum__name')
    list_per_page = 50


@admin.register(PostImage)
class PostImageAdmin(admin.ModelAdmin):
    list_display = ('post', 'caption', 'uploaded_at')
    list_filter = ('uploaded_at',)
    search_fields = ('post__title', 'caption')
    list_per_page = 50


@admin.register(PostLink)
class PostLinkAdmin(admin.ModelAdmin):
    list_display = ('title', 'post', 'url', 'added_at')
    list_filter = ('added_at',)
    search_fields = ('title', 'url', 'post__title')
    list_per_page = 50


@admin.register(Comment)
class CommentAdmin(admin.ModelAdmin):
    list_display = ('author', 'post', 'parent', 'created_at')
    list_filter = ('created_at',)
    search_fields = ('content', 'author__user__username', 'post__title')
    list_per_page = 50
