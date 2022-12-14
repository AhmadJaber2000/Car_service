import 'package:Car_service/tools/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Functions {
  static void updateAvailablity() {
    final _firestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    final data = {
      'name': _auth.currentUser?.displayName ?? _auth.currentUser!.email,
      'data_time': DateTime.now(),
      'email': _auth.currentUser?.email,
    };
    try {
      _firestore
          .collection(chatCollection)
          .doc(_auth.currentUser?.uid)
          .set(data);
    } catch (e) {
      print(e);
    }
  }
}
