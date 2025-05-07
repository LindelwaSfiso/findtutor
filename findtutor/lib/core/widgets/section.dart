import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String header;
  final bool? shouldShowAction;
  final VoidCallback? onAction;
  final IconData actionIcon;

  const SectionHeader({
    required this.header,
    this.shouldShowAction = false,
    this.onAction,
    this.actionIcon = Icons.edit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          header,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        //
        //
        //
        if (shouldShowAction != null && shouldShowAction == true)
          IconButton(
            onPressed: onAction,
            icon: Icon(actionIcon, size: 16),
          )
      ],
    );
  }
}

class SectionText extends StatelessWidget {
  final String? sectionText;
  final String? emptyText;

  const SectionText({
    required this.sectionText,
    this.emptyText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      sectionText ?? emptyText ?? "Missing section text.",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontStyle: sectionText != null ? FontStyle.normal : FontStyle.italic,
      ),
    );
  }
}

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 12),
        Divider(),
        SizedBox(height: 12),
      ],
    );
  }
}
