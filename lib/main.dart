import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/constants_color.dart';
import 'controllers/controller_main.dart';
import 'screens/screen_contacts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Contacts",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: colorTheme),
      ),
      home: ContactsScreen(),
      onInit: () {
        Get.put(MainController());
      },
    );
  }
}
