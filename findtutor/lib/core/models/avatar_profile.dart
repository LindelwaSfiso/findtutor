import 'package:json_annotation/json_annotation.dart';

part 'avatar_profile.g.dart';

@JsonSerializable()
class AvatarProfile {
  final int id;
  final AvatarUser user;

  final String? avatar;
  final String? headline;

  AvatarProfile({
    required this.id,
    required this.user,
    required this.avatar,
    required this.headline,
  });

  factory AvatarProfile.fromJson(Map<String, dynamic> json) =>
      _$AvatarProfileFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarProfileToJson(this);
}

@JsonSerializable()
class AvatarUser {
  final int id;
  final String username;
  @JsonKey(name: "first_name")
  final String? firstName;
  @JsonKey(name: "last_name")
  final String? lastName;
  final String? email;

  AvatarUser({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory AvatarUser.fromJson(Map<String, dynamic> json) =>
      _$AvatarUserFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarUserToJson(this);

  String fullName() {
    return "$firstName $lastName";
  }
}
