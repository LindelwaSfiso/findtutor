import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/models/generic_error.dart';
import '/core/models/profile.dart';
import '/core/types/types.dart';
import '/features/auth/domain/usecases/signout_use_case.dart';
import '/features/profile/data/models/edit_profile_req_params.dart';
import '/features/profile/data/models/update_tutor_profile_params.dart';
import '/features/profile/data/models/become_tutor_params.dart';
import '/features/profile/domain/usecases/profile_usecases.dart';
import '/features/profile/domain/usecases/update_user_profile.dart';
import '/features/profile/domain/usecases/update_profile_picture.dart';
import '/features/profile/domain/usecases/update_tutor_profile.dart';
import '/features/profile/domain/usecases/become_tutor.dart';
import '/service_locator.dart';

part "profile_events.dart";

part "profile_state.dart";

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<LoadProfileEvent>(_getUserProfile);
    on<UpdateUserProfileEvent>(_updateUserProfile);
    on<UpdateProfilePictureEvent>(_updateProfilePicture);
    on<UpdateTutorProfileEvent>(_updateTutorProfile);
    on<BecomeTutorEvent>(_becomeTutor);
    on<UserSignOutEvent>(_signOutUser);
  }

  Future<void> _getUserProfile(
    ProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: () => true, failure: () => null));
    final response = await sl<GetUserProfileUseCase>().call();
    response.fold(
      (error) {
        emit(
          state.copyWith(
            isLoading: () => false,
            failure: () => error,
            userProfile: () => null,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            isLoading: () => false,
            failure: () => null,
            userProfile: () => data,
          ),
        );
      },
    );
  }

  Future<void> _updateUserProfile(
    ProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(isUpdating: () => true, updateProfileFailure: () => null),
    );
    final event0 = (event as UpdateUserProfileEvent);
    final response = await sl<UpdateUserProfileUseCase>().call(
      params: EditProfileRequestParams(
        id: state.userProfile!.id,
        user: EditProfileUser(
          firstName: event0.firstName,
          lastName: event0.lastName,
          email: event0.email,
        ),
        dateOfBirth: event0.dateOfBirth,
        city: event0.city,
        country: event0.country,
        bio: event0.bio,
      ),
    );
    response.fold(
      (error) {
        emit(
          state.copyWith(
            isUpdating: () => false,
            updateProfileFailure:
                () => GenericError(
                  detail: error.detail ?? "Failed to update profile",
                ),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            isUpdating: () => false,
            updateProfileFailure: () => null,
            userProfile: () => data,
          ),
        );
      },
    );
  }

  Future<void> _updateProfilePicture(
    ProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        isUpdatingPicture: () => true,
        updatePictureFailure: () => null,
      ),
    );
    final response = await sl<UpdateProfilePictureUseCase>().call();
    response.fold(
      (error) {
        emit(
          state.copyWith(
            isUpdatingPicture: () => false,
            updatePictureFailure: () => error,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            isUpdatingPicture: () => false,
            updatePictureFailure: () => null,
            userProfile: () => data,
          ),
        );
      },
    );
  }

  Future<void> _updateTutorProfile(
    ProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        isUpdatingTutorProfile: () => true,
        updateTutorProfileFailure: () => null,
      ),
    );
    final event0 = (event as UpdateTutorProfileEvent);
    final response = await sl<UpdateTutorProfileUseCase>().call(
      params: UpdateTutorProfileParams(
        id: state.userProfile!.tutorProfile!.id,
        subjects: event0.subjects!,
        qualifications: event0.qualifications!,
        experience: event0.experience!,
        hourlyRate: event0.hourlyRate!,
        availability: event0.availability!,
      ),
    );
    response.fold(
      (error) {
        emit(
          state.copyWith(
            isUpdatingTutorProfile: () => false,
            updateTutorProfileFailure: () => error,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            isUpdatingTutorProfile: () => false,
            updateTutorProfileFailure: () => null,
            userProfile: () => data,
          ),
        );
      },
    );
  }

  Future<void> _becomeTutor(
    ProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        isBecomingTutor: () => true,
        becomeTutorFailure: () => null,
      ),
    );
    final event0 = (event as BecomeTutorEvent);
    final response = await sl<BecomeTutorUseCase>().call(
      params: BecomeTutorParams(
        subjects: event0.subjects,
        qualifications: event0.qualifications,
        experience: event0.experience,
        hourlyRate: event0.hourlyRate,
        availability: event0.availability,
      ),
    );
    response.fold(
      (error) {
        emit(
          state.copyWith(
            isBecomingTutor: () => false,
            becomeTutorFailure: () => error,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            isBecomingTutor: () => false,
            becomeTutorFailure: () => null,
            userProfile: () => data,
          ),
        );
      },
    );
  }

  Future<void> _signOutUser(
    ProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isSigningOut: () => true, signOutFailure: () => null));
    final response = await sl<SignOutUseCase>().call();
    response.fold(
      (error) {
        emit(state.copyWith(isSigningOut: () => false, signOutFailure: error));
      },
      (data) {
        emit(state.copyWith(isSigningOut: () => false, signOutFailure: null));
      },
    );
  }
}
