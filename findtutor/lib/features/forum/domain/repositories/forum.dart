import 'package:dartz/dartz.dart';
import 'package:findtutor/core/models/generic_error.dart';

import '../../../../core/models/forum.dart';
import '../../../../core/models/pagination.dart';
import '../../data/models/forum_data_source.dart';

abstract class ForumRepository {
  Future<Either<GenericError, PaginatedResponse<Forum>>> getForums(
    GetForumsParams params,
  );

  Future<Either<CreateForumErrors, Forum>> createForum(
    CreateForumRequestParams params,
  );

  Future<void> joinForum(int forumId);

  Future<void> leaveForum(int forumId);

  Future<void> followForum(int forumId);

  Future<void> unfollowForum(int forumId);

  Future<Either<GenericError, PaginatedResponse<ForumPost>>> getForumPosts(
    GetForumPostsParams params,
  );

  Future<ForumPost> createPost(CreateForumPostParams params);

  Future<void> likePost(int postId);

  Future<void> unlikePost(int postId);
}
