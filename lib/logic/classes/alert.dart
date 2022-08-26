import 'package:flutter/material.dart';
import 'package:shenku/logic/cubit/navigator_cubit.dart';

import '../../constants/fonts.dart';

class Alert {
  Alert({required this.text, this.duration, required this.alertType});

  final AlertType alertType;
  final Duration? duration;
  final String text;

  String get iconUrl => alertType == AlertType.success
      ? 'assets/svg/checkmark-circle.svg'
      : alertType == AlertType.warning
          ? 'assets/svg/alert-triangle.svg'
          : 'assets/svg/close-circle.svg';

  Color get backgroundColor => alertType == AlertType.success
      ? const Color(0xffE6FFE8)
      : alertType == AlertType.warning
          ? const Color(0xffFFFAE2)
          : const Color(0xffFFF4EE);

  static double get kBarHeight => 64;

  static Duration get kDialogueDuration => const Duration(seconds: 5);

  static Color get kCloseIconColor => const Color(0xff0D1C2E);

  static TextStyle get kTextStyle => nunito.copyWith(
        color: const Color(0xff2c2929),
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 22 / 14,
      );
}

enum AlertType {
  success,
  warning,
  error,
}

extension AlertExtensions on BuildContext {
  void showSuccess(String text) {
    navigator.showAlert(
      this,
      Alert(
        text: text,
        alertType: AlertType.success,
      ),
    );
  }

  void showWarning(String text) {
    navigator.showAlert(
      this,
      Alert(
        text: text,
        alertType: AlertType.warning,
      ),
    );
  }

  void showError(String text) {
    navigator.showAlert(
      this,
      Alert(
        text: text,
        alertType: AlertType.error,
      ),
    );
  }

  void testAlert() {
    navigator.showAlert(
      this,
      Alert(
        text: 'This is an alert test!',
        alertType: AlertType.warning,
        duration: const Duration(hours: 1),
      ),
    );
  }
}
