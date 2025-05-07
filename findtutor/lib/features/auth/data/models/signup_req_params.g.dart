// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_req_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpReqParams _$SignUpReqParamsFromJson(Map<String, dynamic> json) =>
    SignUpReqParams(
      username: json['username'] as String,
      password: json['password'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );

Map<String, dynamic> _$SignUpReqParamsToJson(SignUpReqParams instance) =>
    <String, dynamic>{
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'password': instance.password,
    };
