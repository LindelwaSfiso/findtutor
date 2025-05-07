import 'package:dartz/dartz.dart';
import '../../../../service_locator.dart';
import '../repositories/profile.dart';
import '/core/models/generic_error.dart';
import '/core/models/profile.dart';
import '/core/usecase/use_case.dart';
import '/features/profile/data/models/become_tutor_params.dart';

class BecomeTutorUseCase
    implements UseCase<Either<GenericError, Profile>, BecomeTutorParams> {
  @override
  Future<Either<GenericError, Profile>> call({
    BecomeTutorParams? params,
  }) async {
    if (params == null) {
      return Left(GenericError(detail: "Parameters are required"));
    }
    return await sl<ProfileRepository>().becomeTutor(params);
  }
}
