import 'package:json_annotation/json_annotation.dart';

part 'signup_req_params.g.dart';

@JsonSerializable()
class SignUpReqParams {
  final String username;
  @JsonKey(name: "first_name")
  final String firstName;
  @JsonKey(name: "last_name")
  final String lastName;
  final String password;

  SignUpReqParams({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  factory SignUpReqParams.fromJson(Map<String, dynamic> json) =>
      _$SignUpReqParamsFromJson(json);

  Map<String, dynamic> toJson() => {
        "user": {
          "username": username,
          "first_name": firstName,
          "last_name": lastName,
          "password": password,
        }
      };
}
