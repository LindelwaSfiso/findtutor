// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
  id: (json['id'] as num).toInt(),
  tutorProfile: TutorProfile.fromJson(
    json['tutor_profile'] as Map<String, dynamic>,
  ),
  userProfile: Profile.fromJson(json['user_profile'] as Map<String, dynamic>),
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
  'id': instance.id,
  'tutor_profile': instance.tutorProfile,
  'user_profile': instance.userProfile,
  'rating': instance.rating,
  'comment': instance.comment,
  'created_at': instance.createdAt,
};
