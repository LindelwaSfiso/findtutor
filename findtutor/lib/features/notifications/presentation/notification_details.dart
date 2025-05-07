import 'package:flutter/material.dart';
import '/core/utils/utils.dart';
import '/core/widgets/appbar.dart';
import '/core/models/notification.dart' as notification_model;

class NotificationDetailsScreen extends StatefulWidget {
  final notification_model.Notification notification;

  const NotificationDetailsScreen({super.key, required this.notification});

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NamedAppBar(title: "Notification Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.notification.notificationContent,
              style: TextStyle(fontSize: 16),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              formatDateTimeFromUtc2(widget.notification.createdAt),
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}
