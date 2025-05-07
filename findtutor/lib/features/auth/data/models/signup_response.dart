import 'package:json_annotation/json_annotation.dart';

part 'signup_response.g.dart';

@JsonSerializable()
class SignUpResponse {
  final String? refresh;
  final String? access;

  const SignUpResponse({this.access, this.refresh});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}

@JsonSerializable()
class SignUpUserError {
  final List<String>? password;
  final List<String>? username;
  @JsonKey(name: "first_name")
  final List<String>? firstName;
  @JsonKey(name: "last_name")
  final List<String>? lastName;

  SignUpUserError({
    this.password,
    this.username,
    this.firstName,
    this.lastName,
  });

  factory SignUpUserError.fromJson(Map<String, dynamic> json) =>
      _$SignUpUserErrorFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpUserErrorToJson(this);
}

@JsonSerializable()
class SignUpErrors {
  final String? detail;
  final SignUpUserError? user;

  const SignUpErrors({
    this.detail,
    this.user,
  });

  factory SignUpErrors.fromJson(Map<String, dynamic> json) =>
      _$SignUpErrorsFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpErrorsToJson(this);
}
