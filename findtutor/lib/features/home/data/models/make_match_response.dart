import 'package:json_annotation/json_annotation.dart';

part 'make_match_response.g.dart';

@JsonSerializable()
class MakeMatchRequestResponse {
  final int code;
  final String detail;

  MakeMatchRequestResponse({
    required this.code,
    required this.detail,
  });

  factory MakeMatchRequestResponse.fromJson(Map<String, dynamic> json) => _$MakeMatchRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MakeMatchRequestResponseToJson(this);
}