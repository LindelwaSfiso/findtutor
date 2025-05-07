import 'package:dartz/dartz.dart';
import '../../data/models/become_tutor_params.dart';
import '../../data/models/update_tutor_profile_params.dart';
import '/core/models/generic_error.dart';
import '/core/models/profile.dart';
import '/features/profile/data/models/edit_profile_req_params.dart';
import '/features/profile/data/models/profile_response.dart';

abstract class ProfileRepository {
  Future<Either<GenericError, Profile>> getUserProfile();

  Future<Either<UpdateProfileErrors, Profile>> updateUserProfile(
    EditProfileRequestParams params,
  );

  Future<Either<GenericError, Profile>> updateProfilePicture();

  Future<Either<GenericError, Profile>> updateTutorProfile(
    UpdateTutorProfileParams params,
  );

  Future<Either<GenericError, Profile>> becomeTutor(BecomeTutorParams params);
}
