import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Orientation get orientation => MediaQuery.of(this).orientation;
  Size get size => MediaQuery.of(this).size;
  bool get isPortrait => orientation == Orientation.portrait;

  double width(double ratio) => size.width * ratio;
  double height(double ratio) => size.height * ratio;
  double dynamicWidth(double ratio) =>
      isPortrait ? width(ratio) : height(ratio);
  double dynamicHeight(double ratio) =>
      isPortrait ? height(ratio) : width(ratio);

  EdgeInsetsGeometry dynamicPadding({
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? horizontal,
    double? vertical,
    double? all,
  }) {
    final double left_ = left ?? 0;
    final double top_ = top ?? 0;
    final double right_ = right ?? 0;
    final double bottom_ = bottom ?? 0;
    final double horizontal_ = horizontal ?? 0;
    final double vertical_ = vertical ?? 0;
    final double all_ = all ?? 0;
    final double dynamicWidth_ = dynamicWidth(0.003);
    return EdgeInsets.fromLTRB(
      (all_ + horizontal_ + left_) * dynamicWidth_,
      all_ + vertical_ + top_,
      (all_ + horizontal_ + right_) * dynamicWidth_,
      all_ + vertical_ + bottom_,
    );
  }
}
