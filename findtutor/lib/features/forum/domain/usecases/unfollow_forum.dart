import 'package:findtutor/features/forum/domain/repositories/forum.dart';

import '../../../../core/usecase/use_case.dart';
import '../../../../service_locator.dart';

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
