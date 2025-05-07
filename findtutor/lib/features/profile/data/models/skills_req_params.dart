import 'package:json_annotation/json_annotation.dart';

part 'skills_req_params.g.dart';

@JsonSerializable()
class AddSkillEntryRequestParams {
  final int user;
  @JsonKey(name: "skill_name")
  final String skillName;

  AddSkillEntryRequestParams({
    required this.user,
    required this.skillName,
  });

  factory AddSkillEntryRequestParams.fromJson(Map<String, dynamic> json) =>
      _$AddSkillEntryRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AddSkillEntryRequestParamsToJson(this);
}
