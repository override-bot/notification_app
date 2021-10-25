import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/ui/shared/app_navigator.dart';

enum FeedbackType { error, info }

class AppToast {
  AppToast._instance();
  static AppToast instance = AppToast._instance();

  void showSnackBar({
    String message,
    FeedbackType feedbackType = FeedbackType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    Flushbar(
      messageText: Text(
        message ?? 'Error',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      duration: duration,
      margin: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 36,
      ),
      borderRadius: BorderRadius.circular(4),
      backgroundColor: feedbackType == FeedbackType.error
          ? Colors.red[300]
          : Colors.green[400],
    )..show(AppNavigator.key.currentContext);
  }

  error(String message) {
    showSnackBar(feedbackType: FeedbackType.error, message: message);
  }
}
