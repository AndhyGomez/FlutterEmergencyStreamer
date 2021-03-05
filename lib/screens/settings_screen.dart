import 'package:EmergencyStreamer/components/space_between.dart';
import 'package:EmergencyStreamer/components/submission_buttons.dart';
import 'package:EmergencyStreamer/components/text_entry.dart';
import 'package:EmergencyStreamer/constants.dart';
import 'package:EmergencyStreamer/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static final String id = 'settingsScreen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String userFN = 'First name';
  String userLN = 'Last name';
  String contact1 = 'Contact 1';
  String contact2 = 'Contact 2';
  String contact3 = 'Contact 3';

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

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
                  height: 200.0,
                  child: Image.asset(
                    'images/emergencystreamer.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                // Display Email
                TextEntry(
                  hint: loggedInUser.email,
                  hide: false,
                  actionable: false,
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                // First Name
                TextEntry(
                  hint: userFN,
                  hide: false,
                  actionable: true,
                  onChange: (value) {
                    userFN = value;
                  },
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                // Last Name
                TextEntry(
                  hint: userLN,
                  hide: false,
                  actionable: true,
                  onChange: (value) {
                    userFN = value;
                  },
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                // Contacts Label
                Text(
                  'Available Contacts',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    letterSpacing: 2,
                  ),
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                TextEntry(
                  hint: contact1,
                  hide: false,
                  actionable: true,
                  onChange: (value) {
                    contact1 = value;
                  },
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                TextEntry(
                  hint: contact2,
                  hide: false,
                  actionable: true,
                  onChange: (value) {
                    contact2 = value;
                  },
                ),
                SpaceBetween(
                  spacing: kSpaceBetweenFields,
                ),
                TextEntry(
                  hint: contact3,
                  hide: false,
                  actionable: true,
                  onChange: (value) {
                    contact3 = value;
                  },
                ),
                // Sign out and Save Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubmissionButton(
                      onPress: () {
                        _auth.signOut();
                        Navigator.popAndPushNamed(context, LoginScreen.id);
                      },
                      label: 'Sign Out',
                      width: 150.0,
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    SubmissionButton(
                      onPress: () {
                        // TODO: research ways to store data to maintain persistence with firebase
                        Navigator.pop(context);
                      },
                      label: 'Save',
                      width: 150.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
