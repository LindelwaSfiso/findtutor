part of "forum_bloc.dart";

abstract class ForumEvent {}

class GetForums extends ForumEvent {
  final String? search;
  final bool? isPrivate;
  final int page;
  final int pageSize;

  GetForums({this.search, this.isPrivate, this.page = 1, this.pageSize = 10});
}

class CreateForum extends ForumEvent {
  final String name;
  final String description;
  final bool isPrivate;

  CreateForum({
    required this.name,
    required this.description,
    required this.isPrivate,
  });
}

class JoinForum extends ForumEvent {
  final int forumId;

  JoinForum(this.forumId);
}

class LeaveForum extends ForumEvent {
  final int forumId;

  LeaveForum(this.forumId);
}

class FollowForum extends ForumEvent {
  final int forumId;

  FollowForum(this.forumId);
}

class UnfollowForum extends ForumEvent {
  final int forumId;

  UnfollowForum(this.forumId);
}

class GetForumPosts extends ForumEvent {
  final int forumId;
  final int page;
  final int pageSize;

  GetForumPosts({required this.forumId, this.page = 1, this.pageSize = 10});
}

class CreatePost extends ForumEvent {
  final int forumId;
  final String title;
  final String content;
  final List<String> imageUrls;
  final List<String> linkUrls;

  CreatePost({
    required this.forumId,
    required this.title,
    required this.content,
    this.imageUrls = const [],
    this.linkUrls = const [],
  });
}

class LikePost extends ForumEvent {
  final int postId;

  LikePost(this.postId);
}

class UnlikePost extends ForumEvent {
  final int postId;

  UnlikePost(this.postId);
}
