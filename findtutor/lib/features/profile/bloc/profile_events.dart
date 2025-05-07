part of "profile_bloc.dart";

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfileEvent extends ProfileEvent {
  const LoadProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUserProfileEvent extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String? dateOfBirth;
  final String? city;
  final String? country;
  final String? bio;

  const UpdateUserProfileEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.dateOfBirth,
    this.city,
    this.country,
    this.bio,
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    email,
    dateOfBirth,
    city,
    country,
    bio,
  ];
}

class UpdatePasswordEvent extends ProfileEvent {
  final String currentPassword;
  final String newPassword;

  const UpdatePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword];
}

class UpdateProfilePictureEvent extends ProfileEvent {
  const UpdateProfilePictureEvent();

  @override
  List<Object?> get props => [];
}

class UpdateTutorProfileEvent extends ProfileEvent {
  final String? subjects;
  final String? qualifications;
  final String? experience;
  final double? hourlyRate;
  final String? availability;

  const UpdateTutorProfileEvent({
    this.subjects,
    this.qualifications,
    this.experience,
    this.hourlyRate,
    this.availability,
  });

  @override
  List<Object?> get props => [
    subjects,
    qualifications,
    experience,
    hourlyRate,
    availability,
  ];
}

class BecomeTutorEvent extends ProfileEvent {
  final String subjects;
  final String qualifications;
  final String experience;
  final double hourlyRate;
  final String availability;

  const BecomeTutorEvent({
    required this.subjects,
    required this.qualifications,
    required this.experience,
    required this.hourlyRate,
    required this.availability,
  });

  @override
  List<Object?> get props => [
    subjects,
    qualifications,
    experience,
    hourlyRate,
    availability,
  ];
}

class UserSignOutEvent extends ProfileEvent {
  const UserSignOutEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfileAboutEvent extends ProfileEvent {
  final String about;

  UpdateProfileAboutEvent({required this.about});

  @override
  List<Object?> get props => [about];
}
