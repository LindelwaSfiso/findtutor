import 'package:dartz/dartz.dart';
import 'package:findtutor/core/models/forum.dart';
import 'package:findtutor/core/models/pagination.dart';
import 'package:findtutor/features/forum/data/models/forum_data_source.dart';
import 'package:findtutor/features/forum/domain/repositories/forum.dart';

import '../../../../core/models/generic_error.dart';
import '../../../../core/usecase/use_case.dart';
import '../../../../service_locator.dart';

class GetForumPosts
    extends UseCase<Either<GenericError, PaginatedResponse<ForumPost>>, GetForumPostsParams> {
  @override
  Future<Either<GenericError, PaginatedResponse<ForumPost>>> call({
    GetForumPostsParams? params,
  }) async {
    return await sl<ForumRepository>().getForumPosts(params!);
  }
}

class CreatePostParams {
  final int forumId;
  final String title;
  final String content;
  final List<String> imageUrls;
  final List<String> linkUrls;

  const CreatePostParams({
    required this.forumId,
    required this.title,
    required this.content,
    this.imageUrls = const [],
    this.linkUrls = const [],
  });
}

class CreatePost extends UseCase<ForumPost, CreatePostParams> {
  @override
  Future<ForumPost> call({CreatePostParams? params}) async {
    return await sl<ForumRepository>().createPost(
      CreateForumPostParams(
        forumId: params!.forumId,
        title: params.title,
        content: params.content,
        imageUrls: params.imageUrls,
        linkUrls: params.linkUrls,
      ),
    );
  }
}

class LikePostParams {
  final int postId;

  const LikePostParams({required this.postId});
}

class LikePost extends UseCase<void, LikePostParams> {
  @override
  Future<void> call({LikePostParams? params}) async {
    await sl<ForumRepository>().likePost(params!.postId);
  }
}

class UnlikePostParams {
  final int postId;

  const UnlikePostParams({required this.postId});
}

class UnlikePost extends UseCase<void, UnlikePostParams> {
  @override
  Future<void> call({UnlikePostParams? params}) async {
    await sl<ForumRepository>().unlikePost(params!.postId);
  }
}
