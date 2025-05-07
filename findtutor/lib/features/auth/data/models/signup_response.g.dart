// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) =>
    SignUpResponse(
      access: json['access'] as String?,
      refresh: json['refresh'] as String?,
    );

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) =>
    <String, dynamic>{'refresh': instance.refresh, 'access': instance.access};

SignUpUserError _$SignUpUserErrorFromJson(
  Map<String, dynamic> json,
) => SignUpUserError(
  password:
      (json['password'] as List<dynamic>?)?.map((e) => e as String).toList(),
  username:
      (json['username'] as List<dynamic>?)?.map((e) => e as String).toList(),
  firstName:
      (json['first_name'] as List<dynamic>?)?.map((e) => e as String).toList(),
  lastName:
      (json['last_name'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$SignUpUserErrorToJson(SignUpUserError instance) =>
    <String, dynamic>{
      'password': instance.password,
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };

SignUpErrors _$SignUpErrorsFromJson(Map<String, dynamic> json) => SignUpErrors(
  detail: json['detail'] as String?,
  user:
      json['user'] == null
          ? null
          : SignUpUserError.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SignUpErrorsToJson(SignUpErrors instance) =>
    <String, dynamic>{'detail': instance.detail, 'user': instance.user};
