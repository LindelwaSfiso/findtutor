import 'package:equatable/equatable.dart';
import '/core/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile extends Equatable {
  final int id;
  final User user;
  @JsonKey(name: "user_type")
  final String userType;

  //
  @JsonKey(name: "phone_number")
  final int? phoneNumber;
  final String? city;
  final String? address;
  @JsonKey(name: "profile_pic")
  final String? profilePic;
  final String? bio;

  //
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;

  final TutorProfile? tutorProfile;

  const Profile({
    required this.id,
    required this.user,
    required this.userType,
    this.phoneNumber,
    this.city,
    this.address,
    this.profilePic,
    this.bio,
    required this.createdAt,
    required this.updatedAt,
    this.tutorProfile,
  });

  bool get isTutor => tutorProfile != null;

  @override
  List<Object?> get props => [
    id,
    user,
    userType,
    phoneNumber,
    city,
    address,
    profilePic,
    bio,
    createdAt,
  ];

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  Profile copyWith({User? user}) {
    return Profile(
      id: id,
      user: user ?? this.user,
      userType: userType,
      phoneNumber: phoneNumber,
      city: city,
      address: address,
      profilePic: profilePic,
      bio: bio,
      createdAt: createdAt,
      updatedAt: updatedAt,
      tutorProfile: tutorProfile,
    );
  }
}

@JsonSerializable()
class TutorProfile extends Equatable {
  final String id;
  final String subjects;
  final String qualifications;
  final String experience;
  final double hourlyRate;
  final String availability;

  factory TutorProfile.fromJson(Map<String, dynamic> json) =>
      _$TutorProfileFromJson(json);

  Map<String, dynamic> toJson() => _$TutorProfileToJson(this);

  const TutorProfile({
    required this.id,
    required this.subjects,
    required this.qualifications,
    required this.experience,
    required this.hourlyRate,
    required this.availability,
  });

  @override
  List<Object?> get props => [
    id,
    subjects,
    qualifications,
    experience,
    hourlyRate,
    availability,
  ];
}
