// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_req_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileUser _$EditProfileUserFromJson(Map<String, dynamic> json) =>
    EditProfileUser(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$EditProfileUserToJson(EditProfileUser instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
    };

EditProfileRequestParams _$EditProfileRequestParamsFromJson(
  Map<String, dynamic> json,
) => EditProfileRequestParams(
  id: (json['id'] as num).toInt(),
  user: EditProfileUser.fromJson(json['user'] as Map<String, dynamic>),
  dateOfBirth: json['dob'] as String?,
  city: json['city'] as String?,
  country: json['country'] as String?,
  bio: json['bio'] as String?,
);

Map<String, dynamic> _$EditProfileRequestParamsToJson(
  EditProfileRequestParams instance,
) => <String, dynamic>{
  'id': instance.id,
  'user': instance.user,
  'dob': instance.dateOfBirth,
  'city': instance.city,
  'country': instance.country,
  'bio': instance.bio,
};
