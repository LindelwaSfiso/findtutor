import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/constants/app_constants.dart';
import '/core/navigation/app_navigator.dart';
import '/core/widgets/containers.dart';
import '/features/home/bloc/dashboard_bloc.dart';
import '/features/home/data/models/dashboard_feed_response.dart';
import '/features/notifications/presentation/notifications.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    final dashboard = context.read<DashboardBloc>();

    return BlocProvider(
      create: (context) => dashboard..add(GetDashboardFeedEvent()),
      child: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state.isMakingMatchRequest == false &&
              state.makingRequestFailure == null &&
              state.requestResponse != null) {
            // we have a match request response
            if (state.requestResponse?.code == 201) {
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: const Text(AppConstants.appName),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      AppNavigator.push(context, const NotificationsScreen());
                    },
                  ),
                ),
                //
                //
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Avatar(
                    name:
                    dashboard.state.avatarProfile?.user.fullName() ?? 'UA',
                    shape: AvatarShape.circle(22),
                    placeholderColors: [
                      Theme
                          .of(context)
                          .colorScheme
                          .onPrimary,
                    ],
                    textStyle: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .onSurface,
                    ),
                  ),
                ),
              ],
            ),
            body: buildDashboardContainer(state),
          );
        },
      ),
    );
  }

  //
  //
  Widget buildDashboardContainer(DashboardState state) {
    if (state.dashboardFailure != null) return buildFailedContainer();

    if (state.dashboardFeed != null) {
      return Scaffold(body: buildBodyContainer(state.dashboardFeed!, context));
    }

    return const LoadingContainer();
  }

  Widget buildFailedContainer() {
    return const Scaffold(
      body: Center(
        child: Text(
          "Failed to load your dashboard timeline. An error occurred.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildEmptyDashboardContainer() {
    return const Scaffold(
      body: Center(
        child: Text(
          "Oops, you have nothing on your timeline. Follow more people and make connections to improve your dashboard feed.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  //
  //
  Widget buildBodyContainer(DashboardFeed dashboardFeed, BuildContext context) {
    if (dashboardFeed.results.isEmpty) return buildEmptyDashboardContainer();

    return Column(
      children: [
        SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height - 56 * 3 - 60 - 20,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Placeholder(),
          ),
        ),
        IconTheme.merge(
          data: const IconThemeData(size: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> onRefresh(int lastPostId, BuildContext context) async {}

}
