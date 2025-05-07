import 'package:findtutor/features/forum/domain/repositories/forum.dart';

import '../../../../core/usecase/use_case.dart';
import '../../../../service_locator.dart';

class UnlikePostParams {
  final int postId;

  const UnlikePostParams({required this.postId});
}

class UnlikePost extends UseCase<void, UnlikePostParams> {
  @override
  Future<void> call({UnlikePostParams? params}) async {
    await sl<ForumRepository>().unlikePost(params!.postId);
  }
}
