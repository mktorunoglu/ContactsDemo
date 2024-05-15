import 'package:flutter/material.dart';

import '../container.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      borderRadiusGeometry: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      backgroundColor: Colors.white,
      child: child,
    );
  }
}
