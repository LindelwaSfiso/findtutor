import 'package:json_annotation/json_annotation.dart';

part 'signin_response.g.dart';

@JsonSerializable()
class SignInResponse {
  final String? refresh;
  final String? access;

  const SignInResponse({this.access, this.refresh});

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);
}

@JsonSerializable()
class SignInErrors {
  final String? detail;
  final List<String>? password;
  final List<String>? username;

  const SignInErrors({this.detail, this.password, this.username});

  factory SignInErrors.fromJson(Map<String, dynamic> json) =>
      _$SignInErrorsFromJson(json);

  Map<String, dynamic> toJson() => _$SignInErrorsToJson(this);
}
