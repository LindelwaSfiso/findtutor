part of "dashboard_bloc.dart";

abstract class DashboardEvent {}

class GetDashboardFeedEvent extends DashboardEvent {}

class GetAvatarProfileEvent extends DashboardEvent {}

class RefreshDashboardFeedEvent extends DashboardEvent {
  final int lastUserId;

  RefreshDashboardFeedEvent({required this.lastUserId});
}

class MakeMatchRequestEvent extends DashboardEvent {
  final int sender;
  final int receiver;

  MakeMatchRequestEvent({
    required this.sender,
    required this.receiver,
  });
}

