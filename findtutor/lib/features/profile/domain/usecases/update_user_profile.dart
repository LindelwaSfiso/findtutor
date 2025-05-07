import 'package:dartz/dartz.dart';
import '/core/models/profile.dart';
import '/core/usecase/use_case.dart';
import '/features/profile/data/models/profile_response.dart';
import '/features/profile/domain/repositories/profile.dart';
import '/service_locator.dart';

class UpdateUserProfileUseCase extends UseCase<Either<UpdateProfileErrors, Profile>, dynamic> {
  @override
  Future<Either<UpdateProfileErrors, Profile>> call({params}) {
    return sl<ProfileRepository>().updateUserProfile(params);
  }
}
