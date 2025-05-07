part of "dashboard_bloc.dart";

class DashboardState extends Equatable {
  final bool? isAvatarLoading;
  final AvatarProfile? avatarProfile;
  final Failure? avatarLoadingFailure;

  // load dashboard state
  final bool? isDashboardLoading;
  final DashboardFeed? dashboardFeed;
  final Failure? dashboardFailure;

  //
  final bool? isMakingMatchRequest;
  final Failure? makingRequestFailure;

  //
  final MakeMatchRequestResponse? requestResponse;

  const DashboardState({
    this.isAvatarLoading,
    this.avatarProfile,
    this.avatarLoadingFailure,
    //
    this.isDashboardLoading,
    this.dashboardFeed,
    this.dashboardFailure,
    //
    this.isMakingMatchRequest,
    this.makingRequestFailure,
    //
    this.requestResponse,
  });

  DashboardState copyWith({
    bool? Function()? isAvatarLoading,
    AvatarProfile? Function()? avatarProfile,
    Failure? Function()? avatarLoadingFailure,
    //
    bool? Function()? isDashboardLoading,
    DashboardFeed? Function()? dashboardFeed,
    Failure? Function()? dashboardFailure,
    //
    bool? Function()? isMakingMatchRequest,
    Failure? Function()? makingRequestFailure,

    MakeMatchRequestResponse? Function()? requestResponse,
  }) {
    return DashboardState(
      isAvatarLoading:
          isAvatarLoading != null ? isAvatarLoading() : this.isAvatarLoading,
      avatarProfile:
          avatarProfile != null ? avatarProfile() : this.avatarProfile,
      avatarLoadingFailure:
          avatarLoadingFailure != null
              ? avatarLoadingFailure()
              : this.avatarLoadingFailure,
      //
      isDashboardLoading:
          isDashboardLoading != null
              ? isDashboardLoading()
              : this.isDashboardLoading,
      dashboardFeed:
          dashboardFeed != null ? dashboardFeed() : this.dashboardFeed,
      dashboardFailure:
          dashboardFailure != null ? dashboardFailure() : this.dashboardFailure,
      //
      isMakingMatchRequest:
          isMakingMatchRequest != null
              ? isMakingMatchRequest()
              : this.isMakingMatchRequest,
      makingRequestFailure:
          makingRequestFailure != null
              ? makingRequestFailure()
              : this.makingRequestFailure,

      //
      requestResponse:
          requestResponse != null ? requestResponse() : this.requestResponse,
    );
  }

  @override
  List<Object?> get props => [
    isAvatarLoading,
    avatarProfile,
    avatarLoadingFailure,
    //
    isDashboardLoading,
    dashboardFeed,
    dashboardFailure,
    //
    isMakingMatchRequest,
    makingRequestFailure,
    //
    requestResponse,
  ];
}
