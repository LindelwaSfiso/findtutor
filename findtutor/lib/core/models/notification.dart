import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  final int id;
  @JsonKey(name: "target")
  final int profileId;
  @JsonKey(name: "type")
  final String notificationType;
  @JsonKey(name: "content")
  final String notificationContent;
  @JsonKey(name: "created_at")
  final String createdAt;
  @JsonKey(name: "seen")
  final bool isRead;

  Notification({
    required this.id,
    required this.profileId,
    required this.notificationType,
    required this.notificationContent,
    required this.createdAt,
    required this.isRead,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
