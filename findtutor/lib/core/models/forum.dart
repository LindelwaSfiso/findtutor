import 'package:json_annotation/json_annotation.dart';
import 'profile.dart';

part 'forum.g.dart';

@JsonSerializable()
class Forum {
  final int id;
  final String name;
  final String description;
  final Profile admin;
  @JsonKey(name: "is_private")
  final bool isPrivate;

  //
  @JsonKey(name: "members_count")
  final int membersCount;
  @JsonKey(name: "followers_count")
  final int followersCount;

  //
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;

  Forum({
    required this.id,
    required this.name,
    required this.description,
    required this.admin,
    required this.isPrivate,
    required this.membersCount,
    required this.followersCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Forum.fromJson(Map<String, dynamic> json) => _$ForumFromJson(json);

  Map<String, dynamic> toJson() => _$ForumToJson(this);
}

@JsonSerializable()
class ForumPost {
  final int id;
  final int forum;
  final Profile author;
  final String title;
  final String content;
  @JsonKey(name: "post_type")
  final String postType;

  //
  final List<PostImage> images;
  final List<PostLink> links;
  final List<ForumPostComment> comments;

  //
  @JsonKey(name: "likes_count")
  final int likesCount;
  @JsonKey(name: "comment_count")
  final int commentCount;

  //
  final String createdAt;
  final String updatedAt;

  ForumPost({
    required this.id,
    required this.forum,
    required this.author,
    required this.title,
    required this.content,
    required this.postType,
    required this.images,
    required this.links,
    required this.comments,
    required this.likesCount,
    required this.commentCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ForumPost.fromJson(Map<String, dynamic> json) =>
      _$ForumPostFromJson(json);

  Map<String, dynamic> toJson() => _$ForumPostToJson(this);
}

@JsonSerializable()
class PostImage {
  final int id;
  final int post;
  final String image;
  final String? caption;
  @JsonKey(name: "uploaded_at")
  final String uploadedAt;

  PostImage({
    required this.id,
    required this.image,
    required this.post,
    this.caption,
    required this.uploadedAt,
  });

  factory PostImage.fromJson(Map<String, dynamic> json) =>
      _$PostImageFromJson(json);

  Map<String, dynamic> toJson() => _$PostImageToJson(this);
}

@JsonSerializable()
class PostLink {
  final int id;
  final String url;
  final String title;
  final String? description;
  @JsonKey(name: "added_at")
  final DateTime addedAt;

  PostLink({
    required this.id,
    required this.url,
    required this.title,
    this.description,
    required this.addedAt,
  });

  factory PostLink.fromJson(Map<String, dynamic> json) =>
      _$PostLinkFromJson(json);

  Map<String, dynamic> toJson() => _$PostLinkToJson(this);
}

@JsonSerializable()
class ForumPostComment {
  final int id;
  final int post;
  final Profile author;
  final String content;
  final int? parent;

  //
  final List<ForumPostComment> replies;
  @JsonKey(name: "likes_count")
  final int likesCount;

  //
  final String createdAt;
  final String updatedAt;

  ForumPostComment({
    required this.id,
    required this.post,
    required this.author,
    required this.content,
    this.parent,
    required this.replies,
    required this.likesCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ForumPostComment.fromJson(Map<String, dynamic> json) =>
      _$ForumPostCommentFromJson(json);

  Map<String, dynamic> toJson() => _$ForumPostCommentToJson(this);
}
