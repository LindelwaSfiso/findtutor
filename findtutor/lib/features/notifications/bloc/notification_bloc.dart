import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/models/generic_error.dart';
import '/features/notifications/data/models/get_notifications_response.dart';
import '/features/notifications/domain/usecases/get_notifications.dart';
import '/service_locator.dart';

part "notifications_events.dart";

part "notifications_state.dart";

class NotificationBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationBloc() : super(const NotificationsState()) {
    on<GetNotificationsEvent>(_getUserNotifications);
    on<MarkNotificationAsReadEvent>(_markNotificationAsRead);
    on<MarkAllNotificationAsReadEvent>(_markAllNotificationsAsRead);
  }

  Future<void> _getUserNotifications(
    NotificationsEvent event,
    Emitter<NotificationsState> emit, {
    dynamic params,
  }) async {
    emit(state.copyWith(isLoading: () => true, loadingFailure: () => null));
    final response = await sl<GetNotificationsUseCase>().call(params: params);
    response.fold(
      (error) {
        emit(
          state.copyWith(
            isLoading: () => false,
            loadingFailure: () => error,
            notificationsResponse: () => null,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            isLoading: () => false,
            loadingFailure: () => null,
            notificationsResponse: () => data,
          ),
        );
      },
    );
  }

  Future<void> _markNotificationAsRead(
    NotificationsEvent event,
    Emitter<NotificationsState> emit,
  ) async {}

  Future<void> _markAllNotificationsAsRead(
    NotificationsEvent event,
    Emitter<NotificationsState> emit,
  ) async {}
}
