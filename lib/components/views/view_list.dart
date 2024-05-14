import 'package:flutter/material.dart';

class MyListView extends StatelessWidget {
  const MyListView({
    super.key,
    this.shrinkWrap = false,
    this.physics = const BouncingScrollPhysics(),
    required this.children,
  });

  final bool shrinkWrap;
  final ScrollPhysics physics;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: shrinkWrap,
      physics: physics,
      children: children,
    );
  }
}
