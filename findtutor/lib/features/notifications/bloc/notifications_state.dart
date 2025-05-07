part of "notification_bloc.dart";

class NotificationsState extends Equatable {
  // load profile state
  final bool? isLoading;
  final GetNotificationsResponse? notificationsResponse;
  final GenericError? loadingFailure;

  const NotificationsState({
    this.isLoading,
    this.notificationsResponse,
    this.loadingFailure,
    //
  });

  NotificationsState copyWith({
    bool? Function()? isLoading,
    GetNotificationsResponse? Function()? notificationsResponse,
    GenericError? Function()? loadingFailure,
  }) {
    return NotificationsState(
      isLoading: isLoading != null ? isLoading() : this.isLoading,
      notificationsResponse:
          notificationsResponse != null
              ? notificationsResponse()
              : this.notificationsResponse,
      loadingFailure:
          loadingFailure != null ? loadingFailure() : this.loadingFailure,
    );
  }

  @override
  List<Object?> get props => [isLoading, notificationsResponse, loadingFailure];
}
