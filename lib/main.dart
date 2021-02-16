import 'package:EmergencyStreamer/screens/camera_init.dart';
import 'package:EmergencyStreamer/screens/login_screen.dart';
import 'package:EmergencyStreamer/screens/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initCameras();
  runApp(EmergencyStreamer());
}

class EmergencyStreamer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        MainScreen.id: (contect) => MainScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
      },
    );
  }
}
