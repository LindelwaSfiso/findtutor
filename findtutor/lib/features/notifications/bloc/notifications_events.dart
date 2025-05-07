part of "notification_bloc.dart";

abstract class NotificationsEvent {}

class GetNotificationsEvent extends NotificationsEvent {}

class MarkNotificationAsReadEvent extends NotificationsEvent {
  String about;

  MarkNotificationAsReadEvent({required this.about});
}

class MarkAllNotificationAsReadEvent extends NotificationsEvent {
  String about;

  MarkAllNotificationAsReadEvent({required this.about});
}
