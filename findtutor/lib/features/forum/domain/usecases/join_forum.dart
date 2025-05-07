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
