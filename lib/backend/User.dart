/*
Copyright 2021 STU Computer Science

Class handles users and user data 
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String fname;
  String lname;
  List<String> contacts;
  bool initalized = false;

  User({this.fname, this.lname, this.contacts, this.initalized});

  getFName() => fname;
  getLName() => lname;
  intialized() => initalized;

  static User initialize(DocumentSnapshot doc) {
    if (doc.exists) {
      var temp = User(
          fname: doc.data()['FirstName'],
          lname: doc.data()['Last Name'],
          contacts: [
            doc.data()['Contact1'],
            doc.data()['Contact2'],
            doc.data()['Contact3']
          ],
          initalized: true);
      return temp;
    }
    return User(contacts: [], fname: "", lname: "", initalized: false);
  }
}
