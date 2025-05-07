import 'package:flutter/material.dart';

class EmptyListContainer extends StatelessWidget {
  final String label;

  const EmptyListContainer({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(label, textAlign: TextAlign.center),
      ),
    );
  }
}

class ErrorLoadingContainer extends StatelessWidget {
  final String label;
  final Function()? onRetry;

  const ErrorLoadingContainer({
    super.key,
    required this.label,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(label, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            //
            if (onRetry != null)
              OutlinedButton(
                onPressed: onRetry,
                child: const Text("Retry"),
              ),
          ],
        ),
      ),
    );
  }
}

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
