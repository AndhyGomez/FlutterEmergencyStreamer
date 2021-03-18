import 'package:EmergencyStreamer/backend/User.dart';
import 'package:EmergencyStreamer/backend/backend.dart';
import 'package:EmergencyStreamer/components/space_between.dart';
import 'package:EmergencyStreamer/components/submission_buttons.dart';
import 'package:EmergencyStreamer/components/text_entry.dart';
import 'package:EmergencyStreamer/constants.dart';
import 'package:EmergencyStreamer/screens/login_screen.dart';
import 'package:EmergencyStreamer/screens/main_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static final String id = 'settingsScreen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  User loggedInUser;
  String currentUserId;
  String userFN = 'First name';
  String userLN = 'Last name';
  String contact1 = 'Contact Phone';
  String contact2 = 'Contact Phone';
  String contact3 = 'Contact Phone';

  @override
  void initState() {
    super.initState();
    setState(() {
      loggedInUser = BackEnd.getLocalUser();
    });
    if (loggedInUser.initalized) {
      userFN = loggedInUser.fname;
      userLN = loggedInUser.lname;
      contact1 = loggedInUser.contacts[0];
      contact2 = loggedInUser.contacts[1];
      contact3 = loggedInUser.contacts[2];
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
                  hint: BackEnd.getCurrentUserEmail(),
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
                    setState(() {
                      userFN = value;
                    });
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
                    setState(() {
                      userLN = value;
                    });
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
                    setState(() {
                      contact1 = value;
                    });
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
                    setState(() {
                      contact2 = value;
                    });
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
                    setState(() {
                      contact3 = value;
                    });
                  },
                ),
                // Sign out and Save Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubmissionButton(
                      onPress: () {
                        BackEnd.signOut();
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
                        BackEnd.updateUserSettings(
                            userFN, userLN, contact1, contact2, contact3);
                        Navigator.popAndPushNamed(context, MainScreen.id);
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
