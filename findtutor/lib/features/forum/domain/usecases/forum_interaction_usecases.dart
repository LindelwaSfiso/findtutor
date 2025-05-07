import 'package:findtutor/features/forum/domain/repositories/forum.dart';

import '../../../../core/usecase/use_case.dart';
import '../../../../service_locator.dart';

class JoinForumParams {
  final int forumId;

  const JoinForumParams({required this.forumId});
}

class JoinForum extends UseCase<void, JoinForumParams> {
  @override
  Future<void> call({JoinForumParams? params}) async {
    await sl<ForumRepository>().joinForum(params!.forumId);
  }
}

class LeaveForumParams {
  final int forumId;

  const LeaveForumParams({required this.forumId});
}

class LeaveForum extends UseCase<void, LeaveForumParams> {
  @override
  Future<void> call({LeaveForumParams? params}) async {
    await sl<ForumRepository>().leaveForum(params!.forumId);
  }
}

class FollowForumParams {
  final int forumId;

  const FollowForumParams({required this.forumId});
}

class FollowForum extends UseCase<void, FollowForumParams> {
  @override
  Future<void> call({FollowForumParams? params}) async {
    await sl<ForumRepository>().followForum(params!.forumId);
  }
}

class UnfollowForumParams {
  final int forumId;

  const UnfollowForumParams({required this.forumId});
}

class UnfollowForum extends UseCase<void, UnfollowForumParams> {
  @override
  Future<void> call({UnfollowForumParams? params}) async {
    await sl<ForumRepository>().unfollowForum(params!.forumId);
  }
}
