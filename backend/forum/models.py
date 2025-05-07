from django.db import models
from django.contrib.auth.models import User
from core.models import UserProfile


class Forum(models.Model):
    name = models.CharField(max_length=200)
    description = models.TextField()
    #
    admin = models.ForeignKey(UserProfile, on_delete=models.CASCADE, related_name='administered_forums')
    is_private = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    #
    members = models.ManyToManyField(UserProfile, through='ForumMembership', related_name='joined_forums')
    followers = models.ManyToManyField(UserProfile, related_name='followed_forums')

    def __str__(self):
        return self.name

    class Meta:
        ordering = ['-created_at']


class ForumMembership(models.Model):
    MEMBERSHIP_STATUS = (
        ('pending', 'Pending'),
        ('approved', 'Approved'),
        ('rejected', 'Rejected')
    )

    user = models.ForeignKey(UserProfile, on_delete=models.CASCADE)
    forum = models.ForeignKey(Forum, on_delete=models.CASCADE)
    status = models.CharField(max_length=10, choices=MEMBERSHIP_STATUS, default='pending')
    joined_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        unique_together = ('user', 'forum')


class Post(models.Model):
    POST_TYPE = (
        ('question', 'Question'),
        ('tutorial', 'Tutorial'),
        ('discussion', 'Discussion')
    )

    forum = models.ForeignKey(Forum, on_delete=models.CASCADE, related_name='posts')
    author = models.ForeignKey(UserProfile, on_delete=models.CASCADE, related_name='forum_posts')
    title = models.CharField(max_length=300)
    content = models.TextField()
    post_type = models.CharField(max_length=10, choices=POST_TYPE)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    likes = models.ManyToManyField(UserProfile, related_name='liked_posts')

    def __str__(self):
        return self.title

    class Meta:
        ordering = ['-created_at']


class PostImage(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='images')
    image = models.ImageField(upload_to='forums/posts/')
    caption = models.CharField(max_length=200, blank=True, null=True)
    uploaded_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Image for {self.post.title}"


class PostLink(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='links')
    url = models.URLField()
    title = models.CharField(max_length=200)
    description = models.TextField(blank=True, null=True)
    added_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title


class Comment(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='comments')
    author = models.ForeignKey(UserProfile, on_delete=models.CASCADE, related_name='forum_comments')
    content = models.TextField()
    parent = models.ForeignKey('self', on_delete=models.CASCADE, null=True, blank=True, related_name='replies')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    likes = models.ManyToManyField(UserProfile, related_name='liked_comments')

    def __str__(self):
        return f"Comment by {self.author} on {self.post.title}"

    class Meta:
        ordering = ['created_at']
