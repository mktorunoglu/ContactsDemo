import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({
    super.key,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.width,
    this.height,
    required this.child,
    this.backgroundColor,
    this.borderRadius = 15,
    this.borderColor,
    this.borderWidth = 1,
    this.gradient,
    this.image,
    this.borderRadiusGeometry,
    this.circleShape = false,
  });

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double? width;
  final double? height;
  final Widget? child;
  final Color? backgroundColor;
  final double borderRadius;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final Color? borderColor;
  final double borderWidth;
  final Gradient? gradient;
  final DecorationImage? image;
  final bool circleShape;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: circleShape
            ? null
            : borderRadiusGeometry ?? BorderRadius.circular(borderRadius),
        border: borderColor == null
            ? null
            : Border.all(
                color: borderColor!,
                width: borderWidth,
              ),
        shape: circleShape ? BoxShape.circle : BoxShape.rectangle,
        gradient: gradient,
        image: image,
      ),
      child: child,
    );
  }
}
