import 'package:dio/dio.dart';
import 'package:findtutor/core/models/forum.dart';
import 'package:findtutor/core/models/pagination.dart';

abstract class ForumRemoteDataSource {
  Future<PaginatedResponse<Forum>> getForums({
    String? search,
    bool? isPrivate,
    int page = 1,
    int pageSize = 10,
  });

  Future<Forum> createForum({
    required String name,
    required String description,
    required bool isPrivate,
  });

  Future<void> joinForum(int forumId);
  Future<void> leaveForum(int forumId);
  Future<void> followForum(int forumId);
  Future<void> unfollowForum(int forumId);

  Future<PaginatedResponse<ForumPost>> getForumPosts({
    required int forumId,
    int page = 1,
    int pageSize = 10,
  });

  Future<ForumPost> createPost({
    required int forumId,
    required String title,
    required String content,
    List<String> imageUrls = const [],
    List<String> linkUrls = const [],
  });

  Future<void> likePost(int postId);
  Future<void> unlikePost(int postId);
}

class ForumRemoteDataSourceImpl implements ForumRemoteDataSource {
  final Dio dio;

  ForumRemoteDataSourceImpl(this.dio);

  @override
  Future<PaginatedResponse<Forum>> getForums({
    String? search,
    bool? isPrivate,
    int page = 1,
    int pageSize = 10,
  }) async {
    final response = await dio.get(
      '/api/v1/forum/forums/',
      queryParameters: {
        if (search != null) 'search': search,
        if (isPrivate != null) 'is_private': isPrivate,
        'page': page,
        'page_size': pageSize,
      },
    );

    return PaginatedResponse.fromJson(
      response.data,
      (json) => Forum.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Forum> createForum({
    required String name,
    required String description,
    required bool isPrivate,
  }) async {
    final response = await dio.post(
      '/api/v1/forum/forums/',
      data: {'name': name, 'description': description, 'is_private': isPrivate},
    );

    return Forum.fromJson(response.data);
  }

  @override
  Future<void> joinForum(int forumId) async {
    await dio.post('/api/v1/forum/forums/$forumId/join/');
  }

  @override
  Future<void> leaveForum(int forumId) async {
    await dio.post('/api/v1/forum/forums/$forumId/leave/');
  }

  @override
  Future<void> followForum(int forumId) async {
    await dio.post('/api/v1/forum/forums/$forumId/follow/');
  }

  @override
  Future<void> unfollowForum(int forumId) async {
    await dio.post('/api/v1/forum/forums/$forumId/unfollow/');
  }

  @override
  Future<PaginatedResponse<ForumPost>> getForumPosts({
    required int forumId,
    int page = 1,
    int pageSize = 10,
  }) async {
    final response = await dio.get(
      '/api/v1/forum/forums/$forumId/posts/',
      queryParameters: {'page': page, 'page_size': pageSize},
    );

    return PaginatedResponse.fromJson(
      response.data,
      (json) => ForumPost.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ForumPost> createPost({
    required int forumId,
    required String title,
    required String content,
    List<String> imageUrls = const [],
    List<String> linkUrls = const [],
  }) async {
    final response = await dio.post(
      '/api/v1/forum/forums/$forumId/posts/',
      data: {
        'title': title,
        'content': content,
        'image_urls': imageUrls,
        'link_urls': linkUrls,
      },
    );

    return ForumPost.fromJson(response.data);
  }

  @override
  Future<void> likePost(int postId) async {
    await dio.post('/api/v1/forum/posts/$postId/like/');
  }

  @override
  Future<void> unlikePost(int postId) async {
    await dio.post('/api/v1/forum/posts/$postId/unlike/');
  }
}
