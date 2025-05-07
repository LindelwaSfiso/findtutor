import 'package:dartz/dartz.dart';
import 'package:findtutor/core/models/forum.dart';
import 'package:findtutor/core/models/generic_error.dart';
import 'package:findtutor/core/models/pagination.dart';
import 'package:findtutor/features/forum/data/models/forum_data_source.dart';
import 'package:findtutor/features/forum/domain/repositories/forum.dart';

import '../../../../core/usecase/use_case.dart';
import '../../../../service_locator.dart';

class GetForums
    extends
        UseCase<
          Either<GenericError, PaginatedResponse<Forum>>,
          GetForumsParams
        > {
  @override
  Future<Either<GenericError, PaginatedResponse<Forum>>> call({
    GetForumsParams? params,
  }) async {
    return await sl<ForumRepository>().getForums(params!);
  }
}
