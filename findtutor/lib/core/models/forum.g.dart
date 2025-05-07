// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Forum _$ForumFromJson(Map<String, dynamic> json) => Forum(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
  admin: Profile.fromJson(json['admin'] as Map<String, dynamic>),
  isPrivate: json['is_private'] as bool,
  membersCount: (json['members_count'] as num).toInt(),
  followersCount: (json['followers_count'] as num).toInt(),
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$ForumToJson(Forum instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'admin': instance.admin,
  'is_private': instance.isPrivate,
  'members_count': instance.membersCount,
  'followers_count': instance.followersCount,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};

ForumPost _$ForumPostFromJson(Map<String, dynamic> json) => ForumPost(
  id: (json['id'] as num).toInt(),
  forum: (json['forum'] as num).toInt(),
  author: Profile.fromJson(json['author'] as Map<String, dynamic>),
  title: json['title'] as String,
  content: json['content'] as String,
  postType: json['post_type'] as String,
  images:
      (json['images'] as List<dynamic>)
          .map((e) => PostImage.fromJson(e as Map<String, dynamic>))
          .toList(),
  links:
      (json['links'] as List<dynamic>)
          .map((e) => PostLink.fromJson(e as Map<String, dynamic>))
          .toList(),
  comments:
      (json['comments'] as List<dynamic>)
          .map((e) => ForumPostComment.fromJson(e as Map<String, dynamic>))
          .toList(),
  likesCount: (json['likes_count'] as num).toInt(),
  commentCount: (json['comment_count'] as num).toInt(),
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
);

Map<String, dynamic> _$ForumPostToJson(ForumPost instance) => <String, dynamic>{
  'id': instance.id,
  'forum': instance.forum,
  'author': instance.author,
  'title': instance.title,
  'content': instance.content,
  'post_type': instance.postType,
  'images': instance.images,
  'links': instance.links,
  'comments': instance.comments,
  'likes_count': instance.likesCount,
  'comment_count': instance.commentCount,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};

PostImage _$PostImageFromJson(Map<String, dynamic> json) => PostImage(
  id: (json['id'] as num).toInt(),
  image: json['image'] as String,
  post: (json['post'] as num).toInt(),
  caption: json['caption'] as String?,
  uploadedAt: json['uploaded_at'] as String,
);

Map<String, dynamic> _$PostImageToJson(PostImage instance) => <String, dynamic>{
  'id': instance.id,
  'post': instance.post,
  'image': instance.image,
  'caption': instance.caption,
  'uploaded_at': instance.uploadedAt,
};

PostLink _$PostLinkFromJson(Map<String, dynamic> json) => PostLink(
  id: (json['id'] as num).toInt(),
  url: json['url'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  addedAt: DateTime.parse(json['added_at'] as String),
);

Map<String, dynamic> _$PostLinkToJson(PostLink instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'title': instance.title,
  'description': instance.description,
  'added_at': instance.addedAt.toIso8601String(),
};

ForumPostComment _$ForumPostCommentFromJson(Map<String, dynamic> json) =>
    ForumPostComment(
      id: (json['id'] as num).toInt(),
      post: (json['post'] as num).toInt(),
      author: Profile.fromJson(json['author'] as Map<String, dynamic>),
      content: json['content'] as String,
      parent: (json['parent'] as num?)?.toInt(),
      replies:
          (json['replies'] as List<dynamic>)
              .map((e) => ForumPostComment.fromJson(e as Map<String, dynamic>))
              .toList(),
      likesCount: (json['likes_count'] as num).toInt(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$ForumPostCommentToJson(ForumPostComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post': instance.post,
      'author': instance.author,
      'content': instance.content,
      'parent': instance.parent,
      'replies': instance.replies,
      'likes_count': instance.likesCount,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
