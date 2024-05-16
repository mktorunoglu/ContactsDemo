import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class MyImageViewer extends StatelessWidget {
  const MyImageViewer({
    super.key,
    this.url,
    this.path,
    this.height,
    this.width,
    this.circleShape = false,
    this.gestureMode = false,
    this.filterColor,
    this.indicatorColor,
    this.fit = BoxFit.cover,
    this.placeholderIcon = Icons.image_not_supported,
    this.placeholderIconSize,
  });

  final String? url;
  final String? path;
  final double? height;
  final double? width;
  final bool circleShape;
  final bool gestureMode;
  final Color? filterColor;
  final Color? indicatorColor;
  final BoxFit fit;
  final IconData placeholderIcon;
  final double? placeholderIconSize;

  @override
  Widget build(BuildContext context) {
    if ((path ?? "").isNotEmpty) {
      return ExtendedImage.file(
        File(path!),
        height: height,
        width: width,
        shape: circleShape ? BoxShape.circle : null,
        fit: fit,
        mode: gestureMode ? ExtendedImageMode.gesture : ExtendedImageMode.none,
        color: filterColor,
      );
    }
    return ExtendedImage.network(
      url ?? "",
      loadStateChanged: loadStateChanged,
    );
  }

  Widget loadStateChanged(ExtendedImageState state) =>
      {
        LoadState.loading: SizedBox(
          height: height,
          width: width,
          child: Center(
            child: CircularProgressIndicator(color: indicatorColor),
          ),
        ),
        LoadState.completed: ExtendedImage.network(
          url ?? "",
          height: height,
          width: width,
          shape: circleShape ? BoxShape.circle : null,
          fit: fit,
          mode:
              gestureMode ? ExtendedImageMode.gesture : ExtendedImageMode.none,
          color: filterColor,
        ),
      }[state.extendedImageLoadState] ??
      SizedBox(
        height: placeholderIconSize != null ? null : height,
        width: placeholderIconSize != null ? null : width,
        child: Center(
          child: Icon(
            placeholderIcon,
            size: placeholderIconSize,
            color: Colors.grey,
          ),
        ),
      );
}
