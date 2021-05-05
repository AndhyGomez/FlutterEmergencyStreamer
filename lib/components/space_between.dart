/*
Copyright 2021 STU Computer Science

Class holds custom spacing component used throughout app screens
*/

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
