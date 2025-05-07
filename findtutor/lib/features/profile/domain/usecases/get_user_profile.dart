import 'package:dartz/dartz.dart';
import '/core/models/generic_error.dart';
import '/core/models/profile.dart';
import '/core/types/types.dart';
import '/core/usecase/use_case.dart';
import '/features/profile/domain/repositories/profile.dart';
import '/service_locator.dart';

class GetUserProfileUseCase
    extends UseCase<Either<GenericError, Profile>, dynamic> {
  @override
  FutureEitherGeneric<Profile> call({params}) {
    return sl<ProfileRepository>().getUserProfile();
  }
}
