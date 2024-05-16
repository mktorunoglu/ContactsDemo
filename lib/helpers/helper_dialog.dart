import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/texts/text.dart';
import '../constants/constants_color.dart';

class DialogHelper {
  DialogHelper._init();
  static final DialogHelper instance = DialogHelper._init();

  Future<void> showSnackbar(
    String message, {
    IconData icon = Icons.info,
    Color foregroundColor = colorTheme,
    int durationSeconds = 3,
    bool isSuccessful = false,
    bool isUnsuccessful = false,
  }) async {
    final Color color = isSuccessful
        ? colorGreen
        : isUnsuccessful
            ? colorRed
            : foregroundColor;
    await Get.closeCurrentSnackbar();
    Get.rawSnackbar(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      borderRadius: 15,
      dismissDirection: DismissDirection.vertical,
      snackPosition: SnackPosition.BOTTOM,
      animationDuration: const Duration(milliseconds: 300),
      shouldIconPulse: false,
      backgroundColor: Colors.white,
      duration: Duration(seconds: durationSeconds),
      boxShadows: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 10,
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
      icon: Icon(
        isSuccessful
            ? Icons.verified
            : isUnsuccessful
                ? Icons.error
                : icon,
        color: color,
      ),
      messageText: MyText(
        message,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  void showBottomSheet(
    Widget bottomSheet, {
    bool isScrollControlled = true,
    bool ignoreSafeArea = false,
  }) =>
      Get.bottomSheet(
        SafeArea(child: bottomSheet),
        isScrollControlled: isScrollControlled,
        ignoreSafeArea: ignoreSafeArea,
      );
}
