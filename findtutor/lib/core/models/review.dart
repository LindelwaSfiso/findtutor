import 'package:findtutor/core/models/profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  final int id;
  @JsonKey(name: 'tutor_profile')
  final TutorProfile tutorProfile;
  @JsonKey(name: 'user_profile')
  final Profile userProfile;
  final int rating;
  final String comment;
  @JsonKey(name: 'created_at')
  final String createdAt;

  Review({
    required this.id,
    required this.tutorProfile,
    required this.userProfile,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
