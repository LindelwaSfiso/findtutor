import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '/core/api/api_client.dart';
import '/core/models/generic_error.dart';
import '/features/notifications/data/models/get_notifications_response.dart';
import '/features/notifications/domain/repositories/notifications.dart';
import '/service_locator.dart';

class NotificationsRepositoryImpl extends NotificationsRepository {
  final restClient = sl<RestClient>();

  @override
  Future<Either<GenericError, GetNotificationsResponse>>
  getUserNotifications() async {
    try {
      final notifications = await restClient.getNotifications();
      return Right(notifications);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return const Left(
          GenericError(detail: "Connection timeout. Please try again."),
        );
      }
      if (e.response?.data != null) {
        return Left(
          GenericError.fromJson(e.response?.data as Map<String, dynamic>),
        );
      }
      return const Left(
        GenericError(
          detail: "Failed to load notifications. Refresh to try again.",
        ),
      );
    } on Exception catch (_) {
      return const Left(
        GenericError(
          detail: "Failed to load user notifications. Refresh to try again.",
        ),
      );
    }
  }
}
