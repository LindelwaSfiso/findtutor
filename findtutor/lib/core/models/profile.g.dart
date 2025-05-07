// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
  id: (json['id'] as num).toInt(),
  user: User.fromJson(json['user'] as Map<String, dynamic>),
  userType: json['user_type'] as String,
  phoneNumber: (json['phone_number'] as num?)?.toInt(),
  city: json['city'] as String?,
  address: json['address'] as String?,
  profilePic: json['profile_pic'] as String?,
  bio: json['bio'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  tutorProfile:
      json['tutorProfile'] == null
          ? null
          : TutorProfile.fromJson(json['tutorProfile'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
  'id': instance.id,
  'user': instance.user,
  'user_type': instance.userType,
  'phone_number': instance.phoneNumber,
  'city': instance.city,
  'address': instance.address,
  'profile_pic': instance.profilePic,
  'bio': instance.bio,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'tutorProfile': instance.tutorProfile,
};

TutorProfile _$TutorProfileFromJson(Map<String, dynamic> json) => TutorProfile(
  id: json['id'] as String,
  subjects: json['subjects'] as String,
  qualifications: json['qualifications'] as String,
  experience: json['experience'] as String,
  hourlyRate: (json['hourlyRate'] as num).toDouble(),
  availability: json['availability'] as String,
);

Map<String, dynamic> _$TutorProfileToJson(TutorProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subjects': instance.subjects,
      'qualifications': instance.qualifications,
      'experience': instance.experience,
      'hourlyRate': instance.hourlyRate,
      'availability': instance.availability,
    };
