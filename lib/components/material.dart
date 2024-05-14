import 'package:flutter/material.dart';

class MyMaterial extends StatelessWidget {
  const MyMaterial({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: child,
    );
  }
}
