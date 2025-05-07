// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarProfile _$AvatarProfileFromJson(Map<String, dynamic> json) =>
    AvatarProfile(
      id: (json['id'] as num).toInt(),
      user: AvatarUser.fromJson(json['user'] as Map<String, dynamic>),
      avatar: json['avatar'] as String?,
      headline: json['headline'] as String?,
    );

Map<String, dynamic> _$AvatarProfileToJson(AvatarProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'avatar': instance.avatar,
      'headline': instance.headline,
    };

AvatarUser _$AvatarUserFromJson(Map<String, dynamic> json) => AvatarUser(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  email: json['email'] as String?,
);

Map<String, dynamic> _$AvatarUserToJson(AvatarUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
    };
