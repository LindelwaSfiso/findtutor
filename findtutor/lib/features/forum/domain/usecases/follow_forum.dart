import 'package:findtutor/features/forum/domain/repositories/forum.dart';

import '../../../../core/usecase/use_case.dart';
import '../../../../service_locator.dart';

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
