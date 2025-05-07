import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HashtagText extends StatelessWidget {
  final String text;

  const HashtagText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];

    text.trim().split(' ').forEach((element) {
      if (element.startsWith('#')) {
        textSpans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        );
      } else if (element.startsWith('www.') || element.startsWith('https://')) {
        textSpans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
        );
      } else {
        textSpans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        );
      }
    });

    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
    );
  }
}
