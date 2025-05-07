import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:findtutor/core/models/forum.dart';

import 'package:findtutor/core/models/generic_error.dart';

import 'package:findtutor/core/models/pagination.dart';

import 'package:findtutor/features/forum/data/models/forum_data_source.dart';

import '../../../../core/api/api_client.dart';
import '../../../../service_locator.dart';
import '../../domain/repositories/forum.dart';

class ForumRepositoryImpl extends ForumRepository {
  final restClient = sl<RestClient>();

  @override
  Future<Either<CreateForumErrors, Forum>> createForum(
    CreateForumRequestParams params,
  ) async {
    try {
      final response = await restClient.createForum(params);
      return Right(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Left(
          CreateForumErrors(detail: "Connection timeout. Please try again."),
        );
      }
      if (e.response?.data != null) {
        return Left(
          CreateForumErrors.fromJson(e.response?.data as Map<String, dynamic>),
        );
      }
      return Left(CreateForumErrors(detail: "Failed to create forum."));
    } on Exception catch (_) {
      return Left(CreateForumErrors(detail: "Failed to create forum."));
    }
  }

  @override
  Future<ForumPost> createPost(CreateForumPostParams params) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<void> followForum(int forumId) {
    // TODO: implement followForum
    throw UnimplementedError();
  }

  @override
  Future<Either<GenericError, PaginatedResponse<ForumPost>>> getForumPosts(
    GetForumPostsParams params,
  ) async {
    try {
      final forumsPosts = await restClient.getForumPosts(params.forumId);
      return Right(forumsPosts);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return const Left(
          GenericError(detail: "Connection timeout. Please try again."),
        );
      }
      if (e.response?.data != null) {
        return Left(
          GenericError.fromJson(e.response?.data as Map<String, dynamic>),
        );
      }
      return const Left(
        GenericError(detail: "Failed to load forum posts. Refresh to try again."),
      );
    } on Exception catch (_) {
      return const Left(
        GenericError(detail: "Failed to load forum posts. Refresh to try again."),
      );
    }
  }

  @override
  Future<Either<GenericError, PaginatedResponse<Forum>>> getForums(
    GetForumsParams params,
  ) async {
    try {
      final forums = await restClient.getForums();
      return Right(forums);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return const Left(
          GenericError(detail: "Connection timeout. Please try again."),
        );
      }
      if (e.response?.data != null) {
        return Left(
          GenericError.fromJson(e.response?.data as Map<String, dynamic>),
        );
      }
      return const Left(
        GenericError(detail: "Failed to load forums. Refresh to try again."),
      );
    } on Exception catch (_) {
      return const Left(
        GenericError(detail: "Failed to load forums. Refresh to try again."),
      );
    }
  }

  @override
  Future<void> joinForum(int forumId) {
    // TODO: implement joinForum
    throw UnimplementedError();
  }

  @override
  Future<void> leaveForum(int forumId) {
    // TODO: implement leaveForum
    throw UnimplementedError();
  }

  @override
  Future<void> likePost(int postId) {
    // TODO: implement likePost
    throw UnimplementedError();
  }

  @override
  Future<void> unfollowForum(int forumId) {
    // TODO: implement unfollowForum
    throw UnimplementedError();
  }

  @override
  Future<void> unlikePost(int postId) {
    // TODO: implement unlikePost
    throw UnimplementedError();
  }
}
