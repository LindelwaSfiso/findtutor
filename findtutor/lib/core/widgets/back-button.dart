import 'package:flutter/material.dart';
import '/core/navigation/app_navigator.dart';

class NavigationBackButton extends StatelessWidget {
  const NavigationBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        AppNavigator.back(context);
      },
      icon: const Icon(Icons.arrow_back_ios_new),
    );
  }
}
