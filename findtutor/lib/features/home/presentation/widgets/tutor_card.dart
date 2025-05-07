import 'package:flutter/material.dart';
import 'package:findtutor/core/models/user.dart'; // Assuming Tutor model is here

class TutorCard extends StatelessWidget {
  final User tutor;
  final VoidCallback onTap;

  const TutorCard({Key? key, required this.tutor, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          // You might want to use a more sophisticated image loading widget
          // that handles placeholders and errors.
          backgroundImage: tutor.profilePictureUrl != null
              ? NetworkImage(tutor.profilePictureUrl!)
              : null,
          child: tutor.profilePictureUrl == null
              ? Text(tutor.fullName()?.substring(0, 1) ?? '')
              : null,
        ),
        title: Text(tutor.fullName() ?? 'Unknown Tutor'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Assuming subjects is a list of strings
            Text('Subjects: ${tutor.subjects?.join(', ') ?? 'N/A'}'),
            Text('Rating: ${tutor.rating ?? 'N/A'}'),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}