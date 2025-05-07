import 'package:findtutor/features/forum/bloc/forum_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/home/bloc/dashboard_bloc.dart';
import '/features/profile/bloc/profile_bloc.dart';

class AppNavigator {
  static void pushReplacement(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  static void push(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static void pushDashboardBloc(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return BlocProvider.value(
            value: context.read<DashboardBloc>(),
            child: widget,
          );
        },
      ),
    );
  }

  static void pushForumsBloc(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return BlocProvider.value(
            value: context.read<ForumBloc>(),
            child: widget,
          );
        },
      ),
    );
  }

  static void pushProfileBloc(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return BlocProvider.value(
            value: context.read<ProfileBloc>(),
            child: widget,
          );
        },
      ),
    );
  }

  static void pushAndRemove(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );
  }

  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  static void maybePop(BuildContext context) {
    Navigator.maybePop(context);
  }
}
