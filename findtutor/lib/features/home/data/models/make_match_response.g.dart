// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'make_match_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MakeMatchRequestResponse _$MakeMatchRequestResponseFromJson(
  Map<String, dynamic> json,
) => MakeMatchRequestResponse(
  code: (json['code'] as num).toInt(),
  detail: json['detail'] as String,
);

Map<String, dynamic> _$MakeMatchRequestResponseToJson(
  MakeMatchRequestResponse instance,
) => <String, dynamic>{'code': instance.code, 'detail': instance.detail};
