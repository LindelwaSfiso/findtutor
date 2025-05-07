import 'package:json_annotation/json_annotation.dart';

part 'signin_req_params.g.dart';

@JsonSerializable()
class SignInReqParams {
  final String username;
  final String password;

  SignInReqParams({required this.username, required this.password});

  factory SignInReqParams.fromJson(Map<String, dynamic> json) =>
      _$SignInReqParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SignInReqParamsToJson(this);
}
