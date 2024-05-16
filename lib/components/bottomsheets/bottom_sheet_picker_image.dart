import 'package:flutter/material.dart';

import '../../constants/constants_color.dart';
import '../../helpers/helper_picker_image.dart';
import '../buttons/button_dialog.dart';
import 'bottom_sheet.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({
    super.key,
    required this.onPick,
  });

  final Function(String filePath) onPick;

  @override
  Widget build(BuildContext context) {
    return MyBottomSheet(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DialogButton(
              "Camera",
              icon: Icons.camera_alt_outlined,
              onPressed: () async => onPick(
                await ImagePickerHelper.instance.pickImageFromCamera() ?? "",
              ),
            ),
            DialogButton(
              "Gallery",
              icon: Icons.image_outlined,
              onPressed: () async => onPick(
                await ImagePickerHelper.instance.pickImageFromGallery() ?? "",
              ),
            ),
            const DialogButton(
              "Cancel",
              color: colorTheme,
            ),
          ],
        ),
      ),
    );
  }
}
