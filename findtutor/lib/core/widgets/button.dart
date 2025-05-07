import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final bool isLoading;
  final Function()? onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const DefaultButton({
    super.key,
    required this.isLoading,
    required this.label,
    this.onPressed,
    this.backgroundColor = Colors.blue,
    this.foregroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isLoading,
              child: const SizedBox(
                height: 20.0,
                width: 20.0,
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 2.0),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              label,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}

class PostButton extends StatelessWidget {
  final bool isLoading;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const PostButton({
    super.key,
    required this.isLoading,
    this.onPressed,
    this.backgroundColor = Colors.blue,
    this.foregroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isLoading,
              child: const SizedBox(
                height: 20.0,
                width: 20.0,
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 2.0),
                ),
              ),
            ),
            Visibility(
              visible: !isLoading,
              child: const Text(
                "Post",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
