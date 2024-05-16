import 'package:flutter/material.dart';

import '../../constants/constants_color.dart';
import '../buttons/button_dialog.dart';
import '../texts/text.dart';
import 'bottom_sheet.dart';

class ActionBottomSheet extends StatelessWidget {
  const ActionBottomSheet({
    super.key,
    required this.message,
    this.messageColor = colorRed,
    this.confirmButtonText = "Yes",
    required this.confirmButtonFunction,
    this.cancelButtonText = "No",
  });

  final String message;
  final Color messageColor;
  final String confirmButtonText;
  final Function() confirmButtonFunction;
  final String cancelButtonText;

  @override
  Widget build(BuildContext context) {
    return MyBottomSheet(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText(
              message,
              textAlign: TextAlign.center,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: messageColor,
            ),
            const SizedBox(height: 25),
            DialogButton(
              confirmButtonText,
              onPressed: confirmButtonFunction,
            ),
            DialogButton(cancelButtonText),
          ],
        ),
      ),
    );
  }
}
