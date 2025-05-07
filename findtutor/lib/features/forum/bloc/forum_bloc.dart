import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:findtutor/core/models/forum.dart';
import 'package:findtutor/core/models/pagination.dart';

import '../../../service_locator.dart';
import '../data/models/forum_data_source.dart';
import '../domain/repositories/forum.dart';

part "forum_event.dart";

part "forum_state.dart";

class ForumBloc extends Bloc<ForumEvent, ForumState> {
  ForumBloc() : super(const ForumState()) {
    on<GetForums>(_onGetForums);
    on<CreateForum>(_onCreateForum);
    on<JoinForum>(_onJoinForum);
    on<LeaveForum>(_onLeaveForum);
    on<FollowForum>(_onFollowForum);
    on<UnfollowForum>(_onUnfollowForum);
    on<GetForumPosts>(_onGetForumPosts);
    on<CreatePost>(_onCreatePost);
    on<LikePost>(_onLikePost);
    on<UnlikePost>(_onUnlikePost);
  }

  Future<void> _onGetForums(GetForums event, Emitter<ForumState> emit) async {
    emit(ForumLoading());
    try {
      final forums = await sl<ForumRepository>().getForums(
        GetForumsParams(
          search: event.search,
          isPrivate: event.isPrivate,
          page: event.page,
          pageSize: event.pageSize,
        ),
      );
      forums.fold(
        (error) {
          emit(ForumError(error.toString()));
        },
        (data) {
          emit(ForumLoaded(data));
        },
      );
    } catch (e) {
      emit(ForumError(e.toString()));
    }
  }

  Future<void> _onCreateForum(
    CreateForum event,
    Emitter<ForumState> emit,
  ) async {
    emit(ForumLoading());
    try {
      await sl<ForumRepository>().createForum(
        CreateForumRequestParams(
          name: event.name,
          description: event.description,
          admin: 1,
          isPrivate: event.isPrivate,
        ),
      );
      emit(const ForumActionSuccess('Forum created successfully'));
      add(GetForums());
    } catch (e) {
      emit(ForumError(e.toString()));
    }
  }

  Future<void> _onJoinForum(JoinForum event, Emitter<ForumState> emit) async {
    emit(ForumLoading());
    try {
      //await joinForum(join_forum.JoinForumParams(forumId: event.forumId));
      emit(const ForumActionSuccess('Joined forum successfully'));
      //add(const GetForums());
    } catch (e) {
      emit(ForumError(e.toString()));
    }
  }

  Future<void> _onLeaveForum(LeaveForum event, Emitter<ForumState> emit) async {
    emit(ForumLoading());
    try {
      // await leaveForum(leave_forum.LeaveForumParams(forumId: event.forumId));
      emit(const ForumActionSuccess('Left forum successfully'));
      //add(const GetForums());
    } catch (e) {
      emit(ForumError(e.toString()));
    }
  }

  Future<void> _onFollowForum(
    FollowForum event,
    Emitter<ForumState> emit,
  ) async {
    emit(ForumLoading());
    try {
      //await followForum(follow_forum.FollowForumParams(forumId: event.forumId));
      emit(const ForumActionSuccess('Followed forum successfully'));
      //add(const GetForums());
    } catch (e) {
      emit(ForumError(e.toString()));
    }
  }

  Future<void> _onUnfollowForum(
    UnfollowForum event,
    Emitter<ForumState> emit,
  ) async {
    emit(ForumLoading());
    try {
      // await unfollowForum(
      //   unfollow_forum.UnfollowForumParams(forumId: event.forumId),
      // );
      emit(const ForumActionSuccess('Unfollowed forum successfully'));
      //add(const GetForums());
    } catch (e) {
      emit(ForumError(e.toString()));
    }
  }

  Future<void> _onGetForumPosts(
    GetForumPosts event,
    Emitter<ForumState> emit,
  ) async {
    emit(ForumLoading());
    try {
      final posts = await sl<ForumRepository>().getForumPosts(
        GetForumPostsParams(
          forumId: event.forumId,
          page: event.page,
          pageSize: event.pageSize,
        ),
      );
      posts.fold(
        (error) {
          emit(ForumError(error.toString()));
        },
        (data) {
          emit(ForumPostsLoaded(data));
        },
      );
    } catch (e) {
      emit(ForumError(e.toString()));
    }
  }

  Future<void> _onCreatePost(CreatePost event, Emitter<ForumState> emit) async {
    emit(ForumLoading());
    try {
      // await createPost(
      //   create_post.CreatePostParams(
      //     forumId: event.forumId,
      //     title: event.title,
      //     content: event.content,
      //     imageUrls: event.imageUrls,
      //     linkUrls: event.linkUrls,
      //   ),
      // );
      emit(const ForumActionSuccess('Post created successfully'));
      add(GetForumPosts(forumId: event.forumId));
    } catch (e) {
      emit(ForumError(e.toString()));
    }
  }

  Future<void> _onLikePost(LikePost event, Emitter<ForumState> emit) async {
    emit(ForumLoading());
    try {
      //await likePost(like_post.LikePostParams(postId: event.postId));
      emit(const ForumActionSuccess('Post liked successfully'));
    } catch (e) {
      emit(ForumError(e.toString()));
    }
  }

  Future<void> _onUnlikePost(UnlikePost event, Emitter<ForumState> emit) async {
    emit(ForumLoading());
    try {
      //await unlikePost(unlike_post.UnlikePostParams(postId: event.postId));
      emit(const ForumActionSuccess('Post unliked successfully'));
    } catch (e) {
      emit(ForumError(e.toString()));
    }
  }
}
