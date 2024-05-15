import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  static MainController instance = Get.find();

  final KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();
}
