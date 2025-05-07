import 'package:flutter/material.dart';

class PoweredBy extends StatelessWidget {
  final String companyName;
  final Color hyperLinkColor;

  const PoweredBy({
    super.key,
    this.companyName = "OnPoint Systems Pty (LTD)",
    this.hyperLinkColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontStyle: FontStyle.italic),
          children: [
            TextSpan(
              text: "Powered by ",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextSpan(
              text: companyName,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: hyperLinkColor),
            ),
          ],
        ),
      ),
    );
  }
}
