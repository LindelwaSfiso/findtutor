import 'package:findtutor/core/models/forum.dart';
import 'package:findtutor/features/forum/domain/repositories/forum.dart';

import '../../../../core/usecase/use_case.dart';
import '../../../../service_locator.dart';

class CreateForumPost extends UseCase<ForumPost, dynamic> {
  @override
  Future<ForumPost> call({params}) async {
    return await sl<ForumRepository>().createPost(params);
  }
}
