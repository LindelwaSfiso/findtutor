import 'package:findtutor/features/forum/domain/repositories/forum.dart';

import '../../../../core/usecase/use_case.dart';
import '../../../../service_locator.dart';

class LikePostParams {
  final int postId;

  const LikePostParams({required this.postId});
}

class LikePost extends UseCase<void, LikePostParams> {
  @override
  Future<void> call({LikePostParams? params}) async {
    await sl<ForumRepository>().likePost(params!.postId);
  }
}
