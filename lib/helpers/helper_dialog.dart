import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  DialogHelper._init();
  static final DialogHelper instance = DialogHelper._init();

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
