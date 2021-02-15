import 'package:EmergencyStreamer/components/submission_buttons.dart';
import 'package:EmergencyStreamer/components/space_between.dart';
import 'package:EmergencyStreamer/constants.dart';
import 'package:EmergencyStreamer/screens/main_screen.dart';
import 'package:EmergencyStreamer/screens/sign_up_screen.dart';
import 'package:EmergencyStreamer/components/text_entry.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 250.0,
                  child: Image.asset(
                    'images/emergencystreamer.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextEntry(
                  hint: 'Email',
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                TextEntry(
                  hint: 'Password',
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenSubmission,
                ),
                SubmissionButton(
                  onPress: () {
                    Navigator.pushNamed(context, MainScreen.id);
                  },
                  label: 'Log In',
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpScreen.id);
                  },
                  child: Text(
                    'Don\'t have an account? Sign Up Here',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
