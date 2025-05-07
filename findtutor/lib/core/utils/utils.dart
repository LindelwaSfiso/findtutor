import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

String formatChatDate(dynamic time, {bool withTime = true}) {
  try {
    if (time is String) {
      DateTime parsedTime = DateTime.parse(time);
      if (withTime) {
        return DateFormat("HH:mm dd/MM").format(parsedTime.toLocal());
      } else {
        return DateFormat("dd/MM").format(parsedTime.toLocal());
      }
    } else if (time is DateTime) {
      if (withTime) {
        return DateFormat("MM-dd HH:mm").format(time.toLocal());
      } else {
        return DateFormat("MM/dd").format(time.toLocal());
      }
    } else {
      return DateFormat("HH:mm dd/MM").format(DateTime.now().toLocal());
    }
  } catch (e) {
    return DateFormat("HH:mm dd/MM").format(DateTime.now().toLocal());
  }
}

String formatDateTimeFromUtc(dynamic time) {
  try {
    return DateFormat(
      "yyyy-MM-dd",
    ).format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(time));
  } catch (e) {
    return DateFormat("yyyy-MM-dd").format(DateTime.now());
  }
}

String formatDateTimeFromUtc2(dynamic time, {bool withTime = true}) {
  try {
    if (withTime) {
      return DateFormat(
        "HH:mm  MMMM dd, yyyy",
      ).format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(time));
    }

    return DateFormat(
      "MMMM dd, yyyy",
    ).format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(time));
  } catch (e) {
    return DateFormat("MMMM dd, yyyy").format(DateTime.now());
  }
}

String formatDateTimeFromUtc3(dynamic time) {
  try {
    return DateFormat(
      "MMM dd, yyyy",
    ).format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(time));
  } catch (e) {
    return DateFormat("MMM dd, yyyy").format(DateTime.now());
  }
}
