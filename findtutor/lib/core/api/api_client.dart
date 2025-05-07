import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/forum/data/models/forum_data_source.dart';
import '../models/forum.dart';
import '../models/pagination.dart';
import '/core/models/avatar_profile.dart';
import '/core/models/profile.dart';
import '/features/auth/data/models/signin_req_params.dart';
import '/features/auth/data/models/signin_response.dart';
import '/features/auth/data/models/signup_req_params.dart';
import '/features/auth/data/models/signup_response.dart';
import '/features/home/data/models/dashboard_feed_response.dart';
import '/features/notifications/data/models/get_notifications_response.dart';
import '/features/profile/data/models/edit_profile_req_params.dart';

import '../constants/api_urls.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiUrls.baseApiUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  // authentication

  @POST(ApiUrls.loginUrl)
  Future<SignInResponse> authenticate(@Body() SignInReqParams authRequest);

  @POST(ApiUrls.signUpUrl)
  Future<SignUpResponse> signUp(@Body() SignUpReqParams authRequest);

  /// dashboard

  @GET(ApiUrls.avatarUrl)
  Future<AvatarProfile> getUserAvatar();

  @GET(ApiUrls.dashboardUrl)
  Future<DashboardFeed> getDashboardFeed();

  /// profile

  @GET(ApiUrls.profileUrl)
  Future<Profile> getUserProfile();

  @PATCH("${ApiUrls.usersUrl}{profileId}/")
  Future<Profile> updateUserProfileSection(
    @Body() EditProfileRequestParams params,
    @Path() int profileId,
  );

  /// notifications

  @GET(ApiUrls.notificationsUrl)
  Future<GetNotificationsResponse> getNotifications();

  /// forum

  @GET(ApiUrls.forumsUrl)
  Future<PaginatedResponse<Forum>> getForums();

  @POST(ApiUrls.forumsUrl)
  Future<Forum> createForum(@Body() CreateForumRequestParams params);

  @GET("${ApiUrls.forumsUrl}{forumId}/posts/")
  Future<PaginatedResponse<ForumPost>> getForumPosts(@Path() int forumId);

  @POST("${ApiUrls.forumsUrl}{forumId}/posts/")
  Future<ForumPost> createPost(
    @Body() CreateForumPostParams params,
    @Path() int forumId,
  );

  @POST("${ApiUrls.forumsUrl}posts/{postId}/like/")
  Future<void> likePost(@Path() int postId);

  @POST("${ApiUrls.forumsUrl}{postId}/unlike/")
  Future<void> unlikePost(@Path() int postId);

  @POST("${ApiUrls.forumsUrl}{forumId}/join/")
  Future<void> joinForum(@Path() int forumId);

  @POST("${ApiUrls.forumsUrl}{forumId}/leave/")
  Future<void> leaveForum(@Path() int forumId);

  @POST("${ApiUrls.forumsUrl}{forumId}/follow/")
  Future<void> followForum(@Path() int forumId);

  @POST("${ApiUrls.forumsUrl}{forumId}/unfollow/")
  Future<void> unfollowForum(@Path() int forumId);

  @DELETE("${ApiUrls.forumsUrl}{postId}/")
  Future<void> deletePost(@Path() int postId);

  @DELETE("${ApiUrls.forumsUrl}{forumId}/")
  Future<void> deleteForum(@Path() int forumId);

  @PATCH("${ApiUrls.forumsUrl}{postId}/")
  Future<ForumPost> updatePost(
    @Body() CreateForumPostParams params,
    @Path() int postId,
  );

  @PATCH("${ApiUrls.forumsUrl}{forumId}/")
  Future<Forum> updateForum(
    @Body() CreateForumRequestParams params,
    @Path() int forumId,
  );

  @GET("${ApiUrls.forumsUrl}{postId}/comments/")
  Future<PaginatedResponse<ForumPostComment>> getPostComments(
    @Path() int postId,
  );

  @POST("${ApiUrls.forumsUrl}{postId}/comments/")
  Future<ForumPostComment> createPostComment(
    @Body() ForumPostComment params,
    @Path() int postId,
  );

  @DELETE("${ApiUrls.forumsUrl}{postId}/comments/{commentId}/")
  Future<void> deletePostComment(@Path() int postId, @Path() int commentId);

  @PATCH("${ApiUrls.forumsUrl}{postId}/comments/{commentId}/")
  Future<ForumPostComment> updatePostComment(
    @Body() ForumPostComment params,
    @Path() int postId,
    @Path() int commentId,
  );

  @POST("${ApiUrls.forumsUrl}{postId}/comments/{commentId}/like/")
  Future<void> likePostComment(@Path() int postId, @Path() int commentId);

  @POST("${ApiUrls.forumsUrl}{postId}/comments/{commentId}/unlike/")
  Future<void> unlikePostComment(@Path() int postId, @Path() int commentId);

  @GET("${ApiUrls.forumsUrl}{postId}/comments/{commentId}/replies/")
  Future<PaginatedResponse<ForumPostComment>> getPostCommentReplies(
    @Path() int postId,
    @Path() int commentId,
  );

  @POST("${ApiUrls.forumsUrl}{postId}/comments/{commentId}/replies/")
  Future<ForumPostComment> createPostCommentReply(
    @Body() ForumPostComment params,
    @Path() int postId,
    @Path() int commentId,
  );

  @DELETE("${ApiUrls.forumsUrl}{postId}/comments/{commentId}/replies/{replyId}/")
  Future<void> deletePostCommentReply(
    @Path() int postId,
    @Path() int commentId,
    @Path() int replyId,
  );
}
