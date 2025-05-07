import 'package:dartz/dartz.dart';
import '/core/models/generic_error.dart';
import '/core/types/types.dart';
import '/core/usecase/use_case.dart';
import '/features/notifications/data/models/get_notifications_response.dart';
import '/features/notifications/domain/repositories/notifications.dart';
import '/service_locator.dart';

class GetNotificationsUseCase
    extends UseCase<Either<GenericError, GetNotificationsResponse>, dynamic> {
  @override
  FutureEitherGeneric<GetNotificationsResponse> call({params}) {
    return sl<NotificationsRepository>().getUserNotifications();
  }
}
