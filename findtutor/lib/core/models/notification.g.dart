// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
  id: (json['id'] as num).toInt(),
  profileId: (json['target'] as num).toInt(),
  notificationType: json['type'] as String,
  notificationContent: json['content'] as String,
  createdAt: json['created_at'] as String,
  isRead: json['seen'] as bool,
);

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'target': instance.profileId,
      'type': instance.notificationType,
      'content': instance.notificationContent,
      'created_at': instance.createdAt,
      'seen': instance.isRead,
    };
