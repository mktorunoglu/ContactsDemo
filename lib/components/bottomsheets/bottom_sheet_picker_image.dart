import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants_color.dart';
import '../../helpers/helper_picker_image.dart';
import '../buttons/button_text.dart';
import 'bottom_sheet.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({
    super.key,
    required this.onPick,
  });

  final Function(String path) onPick;

  @override
  Widget build(BuildContext context) {
    return MyBottomSheet(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            textButton(
              "Camera",
              icon: Icons.camera_alt_outlined,
              onPressed: () async => onPick(
                await ImagePickerHelper.instance.pickImageFromCamera() ?? "",
              ),
            ),
            textButton(
              "Gallery",
              icon: Icons.image_outlined,
              onPressed: () async => onPick(
                await ImagePickerHelper.instance.pickImageFromGallery() ?? "",
              ),
            ),
            textButton(
              "Cancel",
              color: colorTheme,
            ),
          ],
        ),
      ),
    );
  }

  Container textButton(
    String text, {
    Color color = Colors.black,
    IconData? icon,
    Function()? onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: MyTextButton(
        text,
        padding: const EdgeInsets.all(12),
        color: color,
        icon: icon,
        showBackgroundColor: true,
        showBorder: true,
        backgroundColor: Colors.grey.shade500,
        borderColor: Colors.grey.shade300,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        iconSize: 24,
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
          Get.back();
        },
      ),
    );
  }
}
