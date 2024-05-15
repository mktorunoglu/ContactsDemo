import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double myWidth(double ratio) => MediaQuery.of(this).size.width * ratio;
  double myHeight(double ratio) => MediaQuery.of(this).size.height * ratio;
}
