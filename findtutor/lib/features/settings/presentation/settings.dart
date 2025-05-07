import 'package:flutter/material.dart';
import '/core/widgets/appbar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: "Settings"),
      body: Placeholder(),
    );
  }
}
