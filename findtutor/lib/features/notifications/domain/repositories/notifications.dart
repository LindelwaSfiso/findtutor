import 'package:dartz/dartz.dart';
import '/core/models/generic_error.dart';
import '/features/notifications/data/models/get_notifications_response.dart';

abstract class NotificationsRepository {
  Future<Either<GenericError, GetNotificationsResponse>> getUserNotifications();
}
