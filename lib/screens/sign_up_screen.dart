import 'package:EmergencyStreamer/components/space_between.dart';
import 'package:EmergencyStreamer/constants.dart';
import 'package:EmergencyStreamer/components/text_entry.dart';
import 'package:EmergencyStreamer/components/submission_buttons.dart';
import 'package:EmergencyStreamer/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  static final String id = 'signUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

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
                Container(
                  height: 250.0,
                  child: Image.asset(
                    'images/emergencystreamer.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                TextEntry(
                  hint: 'Your E-mail',
                  hide: false,
                  onChange: (value) {
                    inputEmail = value;
                  },
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                TextEntry(
                  hint: 'Verify Email',
                  hide: false,
                  onChange: (value) {
                    inputEmailVerif = value;
                  },
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                TextEntry(
                  hint: 'Your Password',
                  hide: true,
                  onChange: (value) {
                    inputPass = value;
                  },
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                TextEntry(
                  hint: 'Verify Password',
                  hide: true,
                  onChange: (value) {
                    inputPassVerif = value;
                  },
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenSubmission,
                ),
                SubmissionButton(
                  onPress: () async {
                    if (inputEmail == inputEmailVerif &&
                        inputPass == inputPassVerif) {
                      verifiedEmail = inputEmail;
                      verifiedPass = inputPass;

                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                          email: verifiedEmail,
                          password: verifiedPass,
                        );
                        if (newUser != null) {
                          Navigator.pushNamed(context, MainScreen.id);
                          print('Account Created');
                        }
                      } catch (e) {
                        print(e);
                      }
                    } else {
                      print('Verification Failed.');
                    }
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
