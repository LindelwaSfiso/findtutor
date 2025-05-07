import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/constants/app_constants.dart';
import '/core/widgets/containers.dart';
import '/features/home/bloc/dashboard_bloc.dart';
import 'package:findtutor/core/navigation/app_navigator.dart';
import 'package:findtutor/features/home/bloc/dashboard_events.dart';
import 'package:findtutor/features/home/bloc/dashboard_state.dart';
import '/features/home/data/models/dashboard_feed_response.dart';
import 'package:findtutor/features/home/presentation/widgets/tutor_card.dart'; // Import TutorCard
import '/features/notifications/presentation/notifications.dart';
import 'package:findtutor/core/models/user.dart'; // Assuming User model is used for tutors

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      // Dispatch event to load more tutors
      context.read<DashboardBloc>().add(GetMoreDashboardFeedEvent());
    }
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
      if (state.dashboardFeed!.results.isEmpty) {
        return buildEmptyDashboardContainer();
      } else {
        return buildBodyContainer(state.dashboardFeed!.results, context);
      }
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

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.9); // Load more when 90% scrolled
  }

  Widget buildBodyContainer(List<User> tutors, BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: tutors.length + (context.watch<DashboardBloc>().state.isLoadingMore ? 1 : 0), // Add 1 for loading indicator
      itemBuilder: (context, index) {
        if (index < tutors.length) {
          final tutor = tutors[index];
          return TutorCard(
            tutor: tutor,
            onTap: () {
              // Navigate to tutor detail screen
              // You'll need to create this screen
              AppNavigator.push(context, TutorDetailScreen(tutorId: tutor.id)); // Assuming User has an 'id'
            },
          );
        } else {
          // Show loading indicator at the bottom
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

// Placeholder for TutorDetailScreen
class TutorDetailScreen extends StatelessWidget {
  final int tutorId;

  const TutorDetailScreen({Key? key, required this.tutorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutor Details'),
      ),
      body: Center(
        child: Text('Details for Tutor ID: $tutorId'),
      ),
    );
  }
}
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
