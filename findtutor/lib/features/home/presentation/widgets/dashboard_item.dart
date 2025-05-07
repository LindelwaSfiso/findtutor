import 'package:flutter/material.dart';
import '/core/models/profile.dart';
import '/core/navigation/app_navigator.dart';
import '/features/home/presentation/pages/view/view_profile.dart';

class DashboardItem extends StatefulWidget {
  final Profile profile;

  const DashboardItem({super.key, required this.profile});

  @override
  State<DashboardItem> createState() => _DashboardItemState();
}

class _DashboardItemState extends State<DashboardItem> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // Use LayoutBuilder to get the parent's constraints.
      builder: (context, constraints) {
        return Stack(
          children: [
            // Image container with rounded corners and shadow for the card effect.
            Container(
              width: constraints.maxWidth, // Use the maximum available width.
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // Rounded corners for the card.
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26, // Shadow color.
                    spreadRadius: 5, // Spread of the shadow.
                    blurRadius: 10, // Blurring of the shadow.
                    offset: Offset(0, 3), // Position of the shadow (x, y).
                  ),
                ],
              ),
              // ClipRRect is used to apply rounded corners to the image.
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                // Same radius as the container.
                child: Image.network(
                  'https://ichef.bbci.co.uk/ace/standard/3840/cpsprodpb/41fb/live/e645c5f0-3ec0-11ef-b8a1-27a1f0efda24.jpg',
                  // Placeholder image.  Replace with your image URL.
                  fit: BoxFit.cover,
                  // Cover the entire container, potentially cropping.
                  // You can add a loadingBuilder if you want to show a loading indicator.
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    //Handles error while loading image
                    return const Center(child: Text('Error Loading Image'));
                  },
                ),
              ),
            ),
            // Text overlay.  Positioned at the bottom.
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  // Gradient for a smooth fade-in effect from the bottom.
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black87, // Fully opaque black.
                      Colors.black26, // Fade to transparent.
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(20), // Padding for the text.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.profile.user.fullName(),
                      style: TextStyle(
                        color: Colors.white, // White text color.
                        fontSize: 24, // Large font size.
                        fontWeight: FontWeight.bold, // Bold font weight.
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.profile.bio ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    //
                    const SizedBox(height: 8),
                    //
                    //
                    ElevatedButton(
                      onPressed:
                          () => {
                            AppNavigator.push(
                              context,
                              ViewUserProfileScreen(profile: widget.profile),
                            ),
                          },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(12),
                      ),
                      child: const Text(
                        'See Profile',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
