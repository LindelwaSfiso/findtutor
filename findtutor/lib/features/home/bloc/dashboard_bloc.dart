import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/models/avatar_profile.dart';
import '/core/types/types.dart';
import '/features/home/data/models/dashboard_feed_response.dart';
import '/features/home/data/models/make_match_response.dart';
import '/features/home/domain/usecases/get_dashboard_feed_use_case.dart';
import '/features/home/domain/usecases/get_user_avatar_use_case.dart';
import '/service_locator.dart';

part "dashboard_events.dart";

part "dashboard_state.dart";

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<GetAvatarProfileEvent>(_getAvatarProfile);
    on<RefreshDashboardFeedEvent>(_refreshDashboardFeed);
    on<GetDashboardFeedEvent>(_getDashboardFeed);
  }

  Future<void> _getAvatarProfile(
    DashboardEvent event,
    Emitter<DashboardState> emit, {
    dynamic params,
  }) async {
    emit(
      state.copyWith(
        isAvatarLoading: () => true,
        avatarLoadingFailure: () => null,
      ),
    );
    final response = await sl<GetUserAvatarUseCase>().call(params: params);
    response.fold(
      (error) {
        emit(
          state.copyWith(
            isAvatarLoading: () => false,
            avatarLoadingFailure: () => error,
            avatarProfile: () => null,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            isAvatarLoading: () => false, // this state is not updating
            avatarLoadingFailure: () => null,
            avatarProfile: () => data,
          ),
        );
      },
    );
  }

  Future<void> _getDashboardFeed(
    DashboardEvent event,
    Emitter<DashboardState> emit, {
    dynamic params,
  }) async {
    emit(
      state.copyWith(
        isAvatarLoading: () => false,
        avatarLoadingFailure: () => null,
        isDashboardLoading: () => true,
        dashboardFailure: () => null,
      ),
    );
    final response = await sl<GetDashboardFeedUseCase>().call(params: params);
    response.fold(
      (error) {
        emit(
          state.copyWith(
            isDashboardLoading: () => false,
            dashboardFailure: () => error,
            dashboardFeed: () => null,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            isDashboardLoading: () => false,
            dashboardFailure: () => null,
            dashboardFeed: () => data,
          ),
        );
      },
    );
  }

  Future<void> _refreshDashboardFeed(
    DashboardEvent event,
    Emitter<DashboardState> emit, {
    dynamic params,
  }) async {
    emit(
      state.copyWith(
        isDashboardLoading: () => true,
        dashboardFailure: () => null,
      ),
    );
    final response = await sl<GetDashboardFeedUseCase>().call(params: params);
    response.fold(
      (error) {
        emit(
          state.copyWith(
            isDashboardLoading: () => false,
            dashboardFailure: () => error,
            dashboardFeed: () => null,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            isDashboardLoading: () => false,
            dashboardFailure: () => null,
            dashboardFeed: () => data,
          ),
        );
      },
    );
  }

}
