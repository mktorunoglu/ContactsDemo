import 'package:flutter/material.dart';

import '../../constants/constants_color.dart';
import '../texts/text.dart';
import 'button.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton(
    this.text, {
    super.key,
    this.padding = const EdgeInsets.all(10),
    this.shape,
    this.borderRadius = 10,
    this.color,
    this.borderWidth = 1,
    required this.onPressed,
    this.onLongPress,
    this.inProgressText,
    this.textAlign = TextAlign.center,
    this.textOverflow = TextOverflow.ellipsis,
    this.fontSize,
    this.fontWeight = FontWeight.w600,
    this.fontStyle,
    this.letterSpacing,
    this.icon,
    this.isDisabled = false,
    this.showBorder = false,
    this.showBackgroundColor = false,
  });

  final EdgeInsetsGeometry padding;
  final OutlinedBorder? shape;
  final double borderRadius;
  final Color? color;
  final double borderWidth;
  final Function()? onPressed;
  final Function()? onLongPress;
  final String? text;
  final String? inProgressText;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final IconData? icon;
  final bool isDisabled;
  final bool showBorder;
  final bool showBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final bool inProgress = (inProgressText ?? "").isNotEmpty;
    final bool isDisabled = this.isDisabled ||
        (onPressed == null && onLongPress == null) ||
        inProgress;
    final Color color = isDisabled ? colorGrey : (this.color ?? colorTheme);

    return MyButton(
      padding: padding,
      shape: shape,
      borderRadius: borderRadius,
      borderColor: showBorder ? color : null,
      borderWidth: borderWidth,
      backgroundColor: showBackgroundColor ? color.withOpacity(0.1) : null,
      foregroundColor: color,
      onPressed: isDisabled ? null : onPressed,
      onLongPress: isDisabled ? null : onLongPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (inProgress || icon != null)
            Padding(
              padding: EdgeInsets.only(right: inProgress ? 15 : 10),
              child: inProgress
                  ? Container(
                      height: 15,
                      width: 15,
                      margin: const EdgeInsets.symmetric(vertical: 2.5),
                      child: CircularProgressIndicator(color: color),
                    )
                  : Icon(
                      icon,
                      size: 20,
                      color: color,
                    ),
            ),
          Flexible(
            child: MyText(
              inProgress ? inProgressText : text,
              color: color,
              textAlign: textAlign,
              overflow: textOverflow,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              letterSpacing: letterSpacing,
            ),
          ),
        ],
      ),
    );
  }
}
