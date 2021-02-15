import 'package:flutter/material.dart';

class SpaceBetween extends StatelessWidget {
  SpaceBetween({@required this.spacing});

  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: spacing,
    );
  }
}
