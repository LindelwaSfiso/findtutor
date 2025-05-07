// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAboutErrors _$UpdateAboutErrorsFromJson(Map<String, dynamic> json) =>
    UpdateAboutErrors(
      detail: json['detail'] as String?,
      about:
          (json['about'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UpdateAboutErrorsToJson(UpdateAboutErrors instance) =>
    <String, dynamic>{'detail': instance.detail, 'about': instance.about};

UpdateUserErrors _$UpdateUserErrorsFromJson(
  Map<String, dynamic> json,
) => UpdateUserErrors(
  firstName:
      (json['first_name'] as List<dynamic>?)?.map((e) => e as String).toList(),
  lastName:
      (json['last_name'] as List<dynamic>?)?.map((e) => e as String).toList(),
  email: (json['email'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$UpdateUserErrorsToJson(UpdateUserErrors instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
    };

UpdateProfileErrors _$UpdateProfileErrorsFromJson(Map<String, dynamic> json) =>
    UpdateProfileErrors(
      detail: json['detail'] as String?,
      user:
          json['user'] == null
              ? null
              : UpdateUserErrors.fromJson(json['user'] as Map<String, dynamic>),
      dateOfBirth:
          (json['date_of_birth'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      city: (json['city'] as List<dynamic>?)?.map((e) => e as String).toList(),
      country:
          (json['country'] as List<dynamic>?)?.map((e) => e as String).toList(),
      bio: (json['bio'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UpdateProfileErrorsToJson(
  UpdateProfileErrors instance,
) => <String, dynamic>{
  'detail': instance.detail,
  'user': instance.user,
  'date_of_birth': instance.dateOfBirth,
  'city': instance.city,
  'country': instance.country,
  'bio': instance.bio,
};

AddExperienceErrors _$AddExperienceErrorsFromJson(
  Map<String, dynamic> json,
) => AddExperienceErrors(
  user: (json['user'] as List<dynamic>?)?.map((e) => e as String).toList(),
  company:
      (json['company'] as List<dynamic>?)?.map((e) => e as String).toList(),
  role: (json['role'] as List<dynamic>?)?.map((e) => e as String).toList(),
  location:
      (json['location'] as List<dynamic>?)?.map((e) => e as String).toList(),
  locationType:
      (json['location_type'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  employmentType:
      (json['employment_type'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  isCurrentRole:
      (json['is_current_role'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  startDate:
      (json['start_date'] as List<dynamic>?)?.map((e) => e as String).toList(),
  endDate:
      (json['end_date'] as List<dynamic>?)?.map((e) => e as String).toList(),
  description:
      (json['description'] as List<dynamic>?)?.map((e) => e as String).toList(),
  detail: json['detail'] as String?,
);

Map<String, dynamic> _$AddExperienceErrorsToJson(
  AddExperienceErrors instance,
) => <String, dynamic>{
  'detail': instance.detail,
  'user': instance.user,
  'company': instance.company,
  'role': instance.role,
  'location': instance.location,
  'location_type': instance.locationType,
  'employment_type': instance.employmentType,
  'is_current_role': instance.isCurrentRole,
  'start_date': instance.startDate,
  'end_date': instance.endDate,
  'description': instance.description,
};

AddEducationErrors _$AddEducationErrorsFromJson(
  Map<String, dynamic> json,
) => AddEducationErrors(
  detail: json['detail'] as String?,
  user: (json['user'] as List<dynamic>?)?.map((e) => e as String).toList(),
  school: (json['school'] as List<dynamic>?)?.map((e) => e as String).toList(),
  degree: (json['degree'] as List<dynamic>?)?.map((e) => e as String).toList(),
  fieldOfStudy:
      (json['field_of_study'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  startDate:
      (json['start_date'] as List<dynamic>?)?.map((e) => e as String).toList(),
  endDate:
      (json['end_date'] as List<dynamic>?)?.map((e) => e as String).toList(),
  grade: (json['grade'] as List<dynamic>?)?.map((e) => e as String).toList(),
  description:
      (json['description'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$AddEducationErrorsToJson(AddEducationErrors instance) =>
    <String, dynamic>{
      'detail': instance.detail,
      'user': instance.user,
      'school': instance.school,
      'degree': instance.degree,
      'field_of_study': instance.fieldOfStudy,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'grade': instance.grade,
      'description': instance.description,
    };

AddSkillErrors _$AddSkillErrorsFromJson(Map<String, dynamic> json) =>
    AddSkillErrors(
      detail: json['detail'] as String?,
      user: (json['user'] as List<dynamic>?)?.map((e) => e as String).toList(),
      skillName:
          (json['skill_name'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$AddSkillErrorsToJson(AddSkillErrors instance) =>
    <String, dynamic>{
      'detail': instance.detail,
      'user': instance.user,
      'skill_name': instance.skillName,
    };
