import 'package:flutter/material.dart';

import '../../helpers/helper_route.dart';
import 'button_text.dart';

class DialogButton extends StatelessWidget {
  const DialogButton(
    this.text, {
    super.key,
    this.color = Colors.black,
    this.icon,
    this.onPressed,
  });

  final String text;
  final Color color;
  final IconData? icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
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
        onPressed: () async {
          if (onPressed != null) {
            onPressed!();
          }
          await RouteHelper.instance.getBackAsync();
        },
      ),
    );
  }
}
