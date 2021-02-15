import 'package:flutter/material.dart';
import 'package:EmergencyStreamer/constants.dart';

class TextEntry extends StatelessWidget {
  TextEntry({this.onChange, @required this.hint});

  final Function onChange;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kRedAccents, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kRedAccents, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
        ),
      ),
    );
  }
}
