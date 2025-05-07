import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:findtutor/features/profile/data/models/become_tutor_params.dart';
import 'package:findtutor/features/profile/data/models/update_tutor_profile_params.dart';
import '/core/api/api_client.dart';
import '/core/models/generic_error.dart';
import '/core/models/profile.dart';
import '/features/profile/data/models/edit_profile_req_params.dart';
import '/features/profile/data/models/profile_response.dart';
import '/features/profile/domain/repositories/profile.dart';
import '/service_locator.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final restClient = sl<RestClient>();

  @override
  Future<Either<GenericError, Profile>> getUserProfile() async {
    try {
      final profile = await restClient.getUserProfile();
      return Right(profile);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return const Left(
          GenericError(detail: "Connection timeout. Please try again."),
        );
      }
      if (e.response?.data != null) {
        return Left(
          GenericError.fromJson(e.response?.data as Map<String, dynamic>),
        );
      }
      return const Left(
        GenericError(
            detail: "Failed to load user profile. Refresh to try again."),
      );
    } on Exception catch (_) {
      return const Left(
        GenericError(
            detail: "Failed to load user profile. Refresh to try again."),
      );
    }
  }

  @override
  Future<Either<UpdateProfileErrors, Profile>> updateUserProfile(
    EditProfileRequestParams params,
  ) async {
    try {
      final response = await restClient.updateUserProfileSection(
        params,
        params.id,
      );
      return Right(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Left(
          UpdateProfileErrors(detail: "Connection timeout. Please try again."),
        );
      }
      if (e.response?.data != null) {
        return Left(
          UpdateProfileErrors.fromJson(
              e.response?.data as Map<String, dynamic>),
        );
      }
      return Left(
        UpdateProfileErrors(detail: "Failed to update user about section."),
      );
    } on Exception catch (_) {
      return Left(
        UpdateProfileErrors(detail: "Failed to update user profile section."),
      );
    }
  }

  @override
  Future<Either<GenericError, Profile>> becomeTutor(BecomeTutorParams params) {
    // TODO: implement becomeTutor
    throw UnimplementedError();
  }

  @override
  Future<Either<GenericError, Profile>> updateProfilePicture() {
    // TODO: implement updateProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<Either<GenericError, Profile>> updateTutorProfile(UpdateTutorProfileParams params) {
    // TODO: implement updateTutorProfile
    throw UnimplementedError();
  }


}
