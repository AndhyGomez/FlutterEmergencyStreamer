import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:EmergencyStreamer/constants.dart';

class MainScreen extends StatefulWidget {
  static final String id = 'mainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: null,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: kRedAccents,
            ),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
            ),
            FloatingActionButton(
              onPressed: () {
                //TODO: Add onPressed camera functionality
              },
              backgroundColor: Colors.red.shade900,
              elevation: 10.0,
              child: Icon(
                Icons.videocam,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
