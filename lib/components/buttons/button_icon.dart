import 'package:flutter/material.dart';

import '../../constants/constants_color.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    super.key,
    required this.onPressed,
    this.splashRadius = 20,
    this.iconSize,
    this.color = colorTheme,
    this.tooltip,
    required this.icon,
  });

  final Function() onPressed;
  final double splashRadius;
  final double? iconSize;
  final Color color;
  final String? tooltip;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: splashRadius,
      iconSize: iconSize,
      color: color,
      tooltip: tooltip,
      icon: Icon(icon),
    );
  }
}
