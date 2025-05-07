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
  Future<Either<GenericError, ForumPost>> createPost(
      CreateForumPostParams params) async {
    try {
      final response = await restClient.createPost(params);
      return Right(response);
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
      return const Left(GenericError(detail: "Failed to create post."));
    } on Exception catch (_) {
      return const Left(GenericError(detail: "Failed to create post."));
    }
  }

  @override
  Future<Either<GenericError, void>> followForum(int forumId) async {
    // TODO: Implement followForum API call and error handling
    throw UnimplementedError(); // Placeholder
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
  Future<Either<GenericError, void>> joinForum(int forumId) async {
    try {
      await restClient.joinForum(forumId);
      return const Right(null);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return const Left(
          GenericError(detail: "Connection timeout. Please try again."),
        );
      }
      if (e.response?.data != null) {
        return Left(
          GenericError.fromJson(e.response?.data as Map<String, dynamic> ),
        );
      }
      return const Left(GenericError(detail: "Failed to join forum."));
    } on Exception catch (_) {
      return const Left(GenericError(detail: "Failed to join forum."));
    }
  }

  @override
  Future<Either<GenericError, void>> leaveForum(int forumId) async {
    try {
      await restClient.leaveForum(forumId);
      return const Right(null);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return const Left(
          GenericError(detail: "Connection timeout. Please try again."),
        );
      }
      if (e.response?.data != null) {
        return Left(
          GenericError.fromJson(e.response?.data as Map<String, dynamic> ),
        );
      }
      return const Left(GenericError(detail: "Failed to leave forum."));
    } on Exception catch (_) {
      return const Left(GenericError(detail: "Failed to leave forum."));
    }
  }

  @override
  Future<Either<GenericError, void>> likePost(int postId) async {
    try {
      await restClient.likePost(postId);
      return const Right(null);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return const Left(
          GenericError(detail: "Connection timeout. Please try again."),
        );
      }
      if (e.response?.data != null) {
        return Left(
          GenericError.fromJson(e.response?.data as Map<String, dynamic> ),
        );
      }
      return const Left(GenericError(detail: "Failed to like post."));
    } on Exception catch (_) {
      return const Left(GenericError(detail: "Failed to like post."));
    }
  }

  @override
  Future<Either<GenericError, void>> unfollowForum(int forumId) async {
    // TODO: Implement unfollowForum API call and error handling
    throw UnimplementedError(); // Placeholder
  }

  @override
  Future<Either<GenericError, void>> unlikePost(int postId) async {
    // TODO: Implement unlikePost API call and error handling
    throw UnimplementedError(); // Placeholder
  }
}
