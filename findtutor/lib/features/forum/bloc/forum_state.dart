part of "forum_bloc.dart";

class ForumState extends Equatable {
  const ForumState();

  @override
  List<Object> get props => [];
}

class ForumLoading extends ForumState {}

class ForumLoaded extends ForumState {
  final PaginatedResponse<Forum> forums;

  const ForumLoaded(this.forums);

  @override
  List<Object> get props => [forums];
}

class ForumError extends ForumState {
  final String message;

  const ForumError(this.message);

  @override
  List<Object> get props => [message];
}

class ForumPostsLoaded extends ForumState {
  final PaginatedResponse<ForumPost> posts;

  const ForumPostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class ForumActionSuccess extends ForumState {
  final String message;

  const ForumActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}
