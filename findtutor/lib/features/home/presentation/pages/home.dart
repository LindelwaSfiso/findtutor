import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../forum/bloc/forum_bloc.dart';
import '/core/widgets/containers.dart';
import '/features/home/bloc/dashboard_bloc.dart';
import '/features/home/presentation/pages/dashboard.dart';
import '/features/notifications/presentation/notifications.dart';
import '/features/profile/presentation/profile.dart';
import '/features/forum/presentation/forum.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final _buildBody = <Widget>[
    const DashboardScreen(),
    const ForumScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => DashboardBloc()..add(GetAvatarProfileEvent()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state.avatarLoadingFailure != null) {
            return ErrorLoadingContainer(
              label: "Failed to load user profile. Try again.",
              onRetry: () {
                context.read<DashboardBloc>().add(GetAvatarProfileEvent());
              },
            );
          }
          if (state.avatarProfile != null) {
            return Scaffold(
              //
              // make the body a stack of all the main activity screens, which will
              // be controlled by the bottom navigation
              body: MultiBlocProvider(
                providers: [BlocProvider(create: (context) => ForumBloc())],
                child: LazyLoadIndexedStack(
                  // rebuild the chats/notifications screen everytime we access it
                  autoDisposeIndexes: [1, 2],
                  index: currentIndex,
                  // the current index selected
                  children: _buildBody,
                ),
              ),
              //
              //
              bottomNavigationBar: NavigationBar(
                backgroundColor: theme.scaffoldBackgroundColor,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                destinations: const [
                  NavigationDestination(
                    tooltip: "Dashboard",
                    icon: Icon(Icons.dashboard_customize_outlined),
                    label: "Home",
                  ),
                  NavigationDestination(
                    tooltip: "Forum",
                    icon: Icon(Icons.forum_outlined),
                    label: "Forum",
                  ),
                  NavigationDestination(
                    tooltip: "Notifications",
                    icon: Icon(Icons.notification_important_outlined),
                    label: "Notifications",
                  ),
                  NavigationDestination(
                    tooltip: "Profile",
                    icon: Icon(Icons.account_circle_outlined),
                    label: "Profile",
                  ),
                ],
                onDestinationSelected: (tabIndex) {
                  setState(() {
                    currentIndex = tabIndex;
                  });
                },
                selectedIndex: currentIndex,
              ),
            );
          }

          return const LoadingContainer();
        },
      ),
    );
  }
}
