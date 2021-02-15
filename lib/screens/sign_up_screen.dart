import 'package:EmergencyStreamer/components/space_between.dart';
import 'package:EmergencyStreamer/constants.dart';
import 'package:EmergencyStreamer/components/text_entry.dart';
import 'package:EmergencyStreamer/components/submission_buttons.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static final String id = 'signUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 250.0,
                  child: Image.asset(
                    'images/emergencystreamer.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                TextEntry(
                  hint: 'Your E-mail',
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                TextEntry(
                  hint: 'Verify Email',
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                TextEntry(
                  hint: 'Your Password',
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                TextEntry(
                  hint: 'Verify Password',
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenSubmission,
                ),
                SubmissionButton(
                  onPress: () {
                    Navigator.pop(context);
                  },
                  label: 'Create Account',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
