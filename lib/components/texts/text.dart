import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText(
    this.text, {
    super.key,
    this.textAlign,
    this.overflow,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.maxLines,
  });

  final String? text;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
