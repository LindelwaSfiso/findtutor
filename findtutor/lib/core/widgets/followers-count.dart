import 'package:flutter/material.dart';

class FollowersCount extends StatelessWidget {
  final int? followers;

  const FollowersCount({required this.followers, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "${followers != null ? (followers! > 0 ? "$followers+" : followers) : 0} followers",
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.italic,
      ),
      textAlign: TextAlign.center,
    );
  }
}
