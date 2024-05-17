import 'package:flutter/material.dart';

import '../../constants/constants_color.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    super.key,
    required this.icon,
    this.widget,
    required this.onPressed,
    this.color = colorTheme,
    this.iconSize,
    this.splashRadius = 20,
    this.tooltip,
    this.isDisabled = false,
  });

  final IconData? icon;
  final Widget? widget;
  final Function()? onPressed;
  final Color color;
  final double? iconSize;
  final double splashRadius;
  final String? tooltip;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isDisabled ? null : onPressed,
      splashRadius: splashRadius,
      splashColor: color.withOpacity(0.2),
      highlightColor: color.withOpacity(0.2),
      tooltip: isDisabled ? null : tooltip,
      icon: widget ??
          Icon(
            icon,
            color: isDisabled ? Colors.grey : color,
            size: iconSize,
          ),
    );
  }
}
