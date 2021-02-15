import 'package:EmergencyStreamer/components/submission_buttons.dart';
import 'package:EmergencyStreamer/components/space_between.dart';
import 'package:EmergencyStreamer/constants.dart';
import 'package:EmergencyStreamer/screens/main_screen.dart';
import 'package:EmergencyStreamer/screens/sign_up_screen.dart';
import 'package:EmergencyStreamer/components/text_entry.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  String userEmail;
  String userPass;

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
                // Logo,
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
                // Email,
                TextEntry(
                  hint: 'Email',
                  hide: false,
                  onChange: (value) {
                    userEmail = value;
                  },
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                // Password,
                TextEntry(
                  hint: 'Password',
                  hide: true,
                  onChange: (value) {
                    userPass = value;
                  },
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenSubmission,
                ),
                // Log in Button,
                SubmissionButton(
                  onPress: () async {
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                        email: userEmail,
                        password: userPass,
                      );
                      if (user != null) {
                        Navigator.pushNamed(context, MainScreen.id);
                      }
                    } catch (e) {
                      print('Login Failed');
                    }
                  },
                  label: 'Log In',
                ),
                // Register text button,
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
