import 'package:flutter/material.dart';

import '../../constants/constants_color.dart';
import '../container.dart';
import '../viewers/viewer_image.dart';

class MyImageAvatar extends StatelessWidget {
  const MyImageAvatar({
    super.key,
    required this.imageUrl,
    this.size,
    this.color = colorTheme,
    this.showBorder = false,
    this.placeholderIcon = Icons.person,
    this.inProgress = false,
    this.onPressed,
  });

  final String? imageUrl;
  final double? size;
  final Color color;
  final bool showBorder;
  final IconData placeholderIcon;
  final bool inProgress;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: MyContainer(
        height: size,
        width: size,
        circleShape: true,
        borderColor: showBorder ? color : null,
        borderWidth: showBorder ? 2 : 0,
        backgroundColor: Colors.white,
        child: AspectRatio(
          aspectRatio: 1,
          child: inProgress
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : MyImageViewer(
                  url: imageUrl,
                  circleShape: true,
                  indicatorColor: color,
                  placeholderIcon: placeholderIcon,
                ),
        ),
      ),
    );
  }
}
