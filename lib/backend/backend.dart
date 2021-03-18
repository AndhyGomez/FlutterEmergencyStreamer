import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:EmergencyStreamer/backend/User.dart' as Local;

class BackEnd {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  static Local.User _localUser;

  static Future<dynamic> signIn(String email, String password) async {
    var result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    initializeLocalUser();
    return result;
  }

  static void signOut() => _auth.signOut();

  static Future<dynamic> register(email, password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  static String getCurrentUID() => _auth.currentUser.uid;

  static String getCurrentUserEmail() => _auth.currentUser.email;

  static User getCurrentUser() => _auth.currentUser;

  static void initializeLocalUser() async {
    var doc = await _fireStore
        .collection("UserSettings")
        .doc(getCurrentUserEmail())
        .get();
    _localUser = Local.User.initialize(doc);
  }

  static Local.User getLocalUser() => _localUser;

  static void updateUserSettings(userFN, userLN, contact1, contact2, contact3) {
    _fireStore.collection("UserSettings").doc(getCurrentUserEmail()).set({
      "FirstName": userFN,
      "Last Name": userLN,
      "Contact1": contact1,
      "Contact2": contact2,
      "Contact3": contact3
    });

    initializeLocalUser();
  }
}
