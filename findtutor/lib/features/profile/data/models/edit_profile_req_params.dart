import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_req_params.g.dart';

@JsonSerializable()
class EditProfileUser {
  @JsonKey(name: "first_name")
  final String firstName;
  @JsonKey(name: "last_name")
  final String lastName;
  final String? email;

  EditProfileUser({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory EditProfileUser.fromJson(Map<String, dynamic> json) =>
      _$EditProfileUserFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileUserToJson(this);
}

@JsonSerializable()
class EditProfileRequestParams {
  final int id;
  final EditProfileUser user;
  @JsonKey(name: "dob")
  final String? dateOfBirth;
  final String? city;
  final String? country;
  final String? bio;

  EditProfileRequestParams({
    required this.id,
    required this.user,
    required this.dateOfBirth,
    required this.city,
    required this.country,
    required this.bio,
  });

  factory EditProfileRequestParams.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileRequestParamsToJson(this);
}
