// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skills_req_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddSkillEntryRequestParams _$AddSkillEntryRequestParamsFromJson(
  Map<String, dynamic> json,
) => AddSkillEntryRequestParams(
  user: (json['user'] as num).toInt(),
  skillName: json['skill_name'] as String,
);

Map<String, dynamic> _$AddSkillEntryRequestParamsToJson(
  AddSkillEntryRequestParams instance,
) => <String, dynamic>{'user': instance.user, 'skill_name': instance.skillName};
