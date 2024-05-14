import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.padding = EdgeInsets.zero,
    this.shape,
    this.borderRadius = 15,
    this.borderRadiusGeometry,
    this.borderColor,
    this.borderWidth = 1,
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    required this.child,
    this.textOverflow,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
  });

  final EdgeInsetsGeometry padding;
  final OutlinedBorder? shape;
  final double borderRadius;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final Color? borderColor;
  final double borderWidth;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Function()? onPressed;
  final Function()? onLongPress;
  final Function(bool isHovered)? onHover;
  final Widget child;
  final TextOverflow? textOverflow;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        padding: padding,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius:
                  borderRadiusGeometry ?? BorderRadius.circular(borderRadius),
            ),
        side: borderColor == null
            ? null
            : BorderSide(
                color: borderColor!,
                width: borderWidth,
              ),
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
          overflow: textOverflow,
        ),
      ),
      child: child,
    );
  }
}
