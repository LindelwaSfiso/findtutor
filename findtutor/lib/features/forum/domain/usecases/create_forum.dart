import 'package:dartz/dartz.dart';
import 'package:findtutor/core/models/forum.dart';
import 'package:findtutor/features/forum/data/models/forum_data_source.dart';
import 'package:findtutor/features/forum/domain/repositories/forum.dart';

import '../../../../core/usecase/use_case.dart';
import '../../../../service_locator.dart';

class CreateForum
    extends
        UseCase<Either<CreateForumErrors, Forum>, CreateForumRequestParams> {
  @override
  Future<Either<CreateForumErrors, Forum>> call({
    CreateForumRequestParams? params,
  }) async {
    return await sl<ForumRepository>().createForum(params!);
  }
}
