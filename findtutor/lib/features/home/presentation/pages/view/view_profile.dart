import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import '/core/models/profile.dart';
import '/core/widgets/appbar.dart';
import '/core/widgets/followers-count.dart';

class ViewUserProfileScreen extends StatefulWidget {
  final Profile profile;

  const ViewUserProfileScreen({super.key, required this.profile});

  @override
  State<ViewUserProfileScreen> createState() => _ViewUserProfileScreenState();
}

class _ViewUserProfileScreenState extends State<ViewUserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: "View Profile"),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          //
          //
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Avatar(
                name: widget.profile.user.fullName(),
                shape: AvatarShape.circle(64),
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
                  fontSize: 24,
                ),
              ),
              //
              //
              const SizedBox(height: 24),
              Text(
                widget.profile.user.fullName(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              //
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.circle, color: Colors.green, size: 10),
                  const SizedBox(width: 4),
                  Text('Online', style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ],
          ),
          //
          //
          const SizedBox(height: 12),
          Text(
            textAlign: TextAlign.center,
            widget.profile.bio?.isNotEmpty == true
                ? widget.profile.bio!
                : "No Bio Yet. Add one soo.",
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 4),
          const FollowersCount(followers: 0),
          const SizedBox(height: 24),
          buildUserPersonalInformation(widget.profile),
          //
          //
          // const SizedBox(height: 24),
          // buildLogoutButton(onUserSignOut),
          // const SizedBox(height: 16),
          //
          //
        ],
      ),
    );
  }

  Widget buildUserPersonalInformation(Profile user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Location Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Location',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                user.city != null ? user.city! : "Eswatini",
                // Replace with actual location
                style: TextStyle(color: Colors.grey),
                maxLines: 1,
              ),
            ],
          ),
        ),
        // Divider
        Container(
          width: 1, // Width of the divider
          height: 30, // Height of the divider
          color: Colors.grey, // Color of the divider
          margin: const EdgeInsets.symmetric(horizontal: 10), // Add spacing
        ),
        // DOB Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'DOB',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),

            ],
          ),
        ),
      ],
    );
  }
}
