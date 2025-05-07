// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) =>
    SignInResponse(
      access: json['access'] as String?,
      refresh: json['refresh'] as String?,
    );

Map<String, dynamic> _$SignInResponseToJson(SignInResponse instance) =>
    <String, dynamic>{'refresh': instance.refresh, 'access': instance.access};

SignInErrors _$SignInErrorsFromJson(Map<String, dynamic> json) => SignInErrors(
  detail: json['detail'] as String?,
  password:
      (json['password'] as List<dynamic>?)?.map((e) => e as String).toList(),
  username:
      (json['username'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$SignInErrorsToJson(SignInErrors instance) =>
    <String, dynamic>{
      'detail': instance.detail,
      'password': instance.password,
      'username': instance.username,
    };
