import 'package:findtutor/features/forum/domain/repositories/forum.dart';

import '../../../../core/usecase/use_case.dart';
import '../../../../service_locator.dart';

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
