import 'package:get/get.dart';

class RouteHelper {
  RouteHelper._init();
  static final RouteHelper instance = RouteHelper._init();

  Future<void> getBackAsync() async {
    await Get.closeCurrentSnackbar();
    await Future.delayed(Duration.zero);
    Get.back();
  }
}
