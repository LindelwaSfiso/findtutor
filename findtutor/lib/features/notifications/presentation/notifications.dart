import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/widgets/appbar.dart';
import '/features/notifications/bloc/notification_bloc.dart';
import '/features/notifications/widgets/notification_item.dart';

import 'notification_details.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc()..add(GetNotificationsEvent()),
      child: BlocBuilder<NotificationBloc, NotificationsState>(
        builder: (context, state) {
          if (state.loadingFailure != null) {
            return showFailedContainer();
          } else if (state.isLoading == true) {
            return buildLoadingScreen();
          }
          //
          //
          else if (state.notificationsResponse != null) {
            final notificationItems = state.notificationsResponse!.results;

            return Scaffold(
              appBar: AppBar(
                title: Text("Notifications"),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: IconButton(
                      tooltip: "Navigate to settings",
                      onPressed: () {
                        // AppNavigator.push(context, const SettingsScreen());
                      },
                      icon: const Icon(Icons.more_vert_outlined),
                    ),
                  ),
                ],
              ),
              body:
                  notificationItems.isEmpty
                      ? buildEmptyContainer()
                      : ListView.builder(
                        itemCount: notificationItems.length,
                        itemBuilder: (context, index) {
                          final item = notificationItems[index];
                          return NotificationItem(
                            notification: item,
                            onTap: () {
                              // Navigate to the NotificationDetailsScreen when a notification is tapped.
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => NotificationDetailsScreen(
                                        notification: item,
                                      ),
                                ),
                              );
                            },
                          );
                        },
                      ),
            );
          }
          //
          return buildLoadingScreen();
        },
      ),
    );
  }

  Widget buildLoadingScreen() {
    return const Scaffold(
      appBar: NamedAppBar(title: "Notifications"),
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Widget showFailedContainer() {
    return const Scaffold(
      appBar: NamedAppBar(title: "Notifications"),
      body: Center(
        child: Text(
          "Failed to load your user notifications. An error occurred.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildEmptyContainer() {
    return const Scaffold(
      body: Center(
        child: Text(
          "Oops, you have no notifications.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
