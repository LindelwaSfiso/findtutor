import 'package:flutter/material.dart';

import 'back-button.dart';

class GenericAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const GenericAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(leading: const NavigationBackButton(), title: Text(title));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class NamedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const NamedAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
