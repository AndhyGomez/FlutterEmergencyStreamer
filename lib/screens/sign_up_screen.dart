import 'package:EmergencyStreamer/backend/backend.dart';
import 'package:EmergencyStreamer/components/space_between.dart';
import 'package:EmergencyStreamer/constants.dart';
import 'package:EmergencyStreamer/components/text_entry.dart';
import 'package:EmergencyStreamer/components/submission_buttons.dart';
import 'package:EmergencyStreamer/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static final String id = 'signUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String inputEmail;
  String inputEmailVerif;
  String inputPass;
  String inputPassVerif;

  String verifiedEmail;
  String verifiedPass;

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
                // Logo,
                Container(
                  height: 250.0,
                  child: Image.asset(
                    'images/emergencystreamer.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                // Email,
                TextEntry(
                  hint: 'Your E-mail',
                  hide: false,
                  actionable: true,
                  onChange: (value) {
                    inputEmail = value;
                  },
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                // Verify Email,
                TextEntry(
                  hint: 'Verify Email',
                  hide: false,
                  actionable: true,
                  onChange: (value) {
                    inputEmailVerif = value;
                  },
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                // Password,
                TextEntry(
                  hint: 'Your Password',
                  hide: true,
                  actionable: true,
                  onChange: (value) {
                    inputPass = value;
                  },
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                // Verify Password,
                TextEntry(
                  hint: 'Verify Password',
                  hide: true,
                  actionable: true,
                  onChange: (value) {
                    inputPassVerif = value;
                  },
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenSubmission,
                ),
                // Create Account
                SubmissionButton(
                  onPress: () async {
                    if (inputEmail == inputEmailVerif &&
                        inputPass == inputPassVerif) {
                      verifiedEmail = inputEmail;
                      verifiedPass = inputPass;

                      try {
                        final newUser =
                            BackEnd.register(verifiedEmail, verifiedPass);
                        if (newUser != null) {
                          Navigator.pushNamed(context, SettingsScreen.id);
                          print('Account Created');
                        }
                      } catch (e) {
                        print('Either your Email or Password do not match');
                      }
                    }
                  },
                  label: 'Create Account',
                  width: 200.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
