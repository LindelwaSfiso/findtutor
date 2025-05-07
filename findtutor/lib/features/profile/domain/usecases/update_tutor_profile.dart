import 'package:dartz/dartz.dart';
import 'package:findtutor/features/profile/domain/repositories/profile.dart';
import '../../../../service_locator.dart';
import '/core/models/generic_error.dart';
import '/core/models/profile.dart';
import '/core/usecase/use_case.dart';

class UpdateTutorProfileUseCase
    implements UseCase<Either<GenericError, Profile>, dynamic> {
  @override
  Future<Either<GenericError, Profile>> call({params}) async {
    return await sl<ProfileRepository>().updateTutorProfile(params);
  }
}
