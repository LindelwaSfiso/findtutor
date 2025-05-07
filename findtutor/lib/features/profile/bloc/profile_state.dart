part of "profile_bloc.dart";

class ProfileState extends Equatable {
  // load profile state
  final bool isLoading;
  final bool isUpdating;
  final bool isSigningOut;
  final bool isUpdatingPicture;
  final bool isUpdatingTutorProfile;
  final bool isBecomingTutor;
  final Profile? userProfile;
  final GenericError? failure;

  final bool? isAdding;
  final Failure? addingFailure;

  final GenericError? updateProfileFailure;
  final GenericError? signOutFailure;
  final GenericError? updatePictureFailure;
  final GenericError? updateTutorProfileFailure;
  final GenericError? becomeTutorFailure;

  const ProfileState({
    this.isLoading = false,
    this.isUpdating = false,
    this.isSigningOut = false,
    this.isUpdatingPicture = false,
    this.isUpdatingTutorProfile = false,
    this.isBecomingTutor = false,
    this.userProfile,
    this.failure,
    this.updateProfileFailure,
    this.signOutFailure,
    this.updatePictureFailure,
    this.updateTutorProfileFailure,
    this.becomeTutorFailure,
    //
    this.isAdding,
    this.addingFailure,
  });

  ProfileState copyWith({
    bool? Function()? isLoading,
    bool? Function()? isUpdating,
    bool? Function()? isSigningOut,
    bool? Function()? isUpdatingPicture,
    bool? Function()? isUpdatingTutorProfile,
    bool? Function()? isBecomingTutor,
    Profile? Function()? userProfile,
    GenericError? Function()? failure,
    GenericError? Function()? updateProfileFailure,
    GenericError? Function()? signOutFailure,
    GenericError? Function()? updatePictureFailure,
    GenericError? Function()? updateTutorProfileFailure,
    GenericError? Function()? becomeTutorFailure,
    //
    bool? Function()? isAdding,
    Failure? Function()? addingFailure,
  }) {
    return ProfileState(
      isLoading:
          isLoading != null ? isLoading() ?? this.isLoading : this.isLoading,
      isUpdating:
          isUpdating != null
              ? isUpdating() ?? this.isUpdating
              : this.isUpdating,
      isSigningOut:
          isSigningOut != null
              ? isSigningOut() ?? this.isSigningOut
              : this.isSigningOut,
      isUpdatingPicture:
          isUpdatingPicture != null
              ? isUpdatingPicture() ?? this.isUpdatingPicture
              : this.isUpdatingPicture,
      isUpdatingTutorProfile:
          isUpdatingTutorProfile != null
              ? isUpdatingTutorProfile() ?? this.isUpdatingTutorProfile
              : this.isUpdatingTutorProfile,
      isBecomingTutor:
          isBecomingTutor != null
              ? isBecomingTutor() ?? this.isBecomingTutor
              : this.isBecomingTutor,
      userProfile: userProfile != null ? userProfile() : this.userProfile,
      failure: failure != null ? failure() : this.failure,
      updateProfileFailure:
          updateProfileFailure != null
              ? updateProfileFailure()
              : this.updateProfileFailure,
      signOutFailure:
          signOutFailure != null ? signOutFailure() : this.signOutFailure,
      updatePictureFailure:
          updatePictureFailure != null
              ? updatePictureFailure()
              : this.updatePictureFailure,
      updateTutorProfileFailure:
          updateTutorProfileFailure != null
              ? updateTutorProfileFailure()
              : this.updateTutorProfileFailure,
      becomeTutorFailure:
          becomeTutorFailure != null
              ? becomeTutorFailure()
              : this.becomeTutorFailure,
      isAdding: isAdding != null ? isAdding() : this.isAdding,
      addingFailure:
          addingFailure != null ? addingFailure() : this.addingFailure,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isUpdating,
    isSigningOut,
    isUpdatingPicture,
    isUpdatingTutorProfile,
    isBecomingTutor,
    userProfile,
    failure,
    updateProfileFailure,
    signOutFailure,
    updatePictureFailure,
    updateTutorProfileFailure,
    becomeTutorFailure,
    isAdding,
    addingFailure,
  ];
}
