import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../ui/home/MechanicHome/MechanicHome.dart';
import '../ui/home/WinchHome/WinchHome.dart';
import '../ui/home/home_screen.dart';

class ViewModel {
  static void route(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('roletype') == RolType.user) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else if (documentSnapshot.get('roletype') == RolType.mechanic) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MechanicHome(),
            ),
          );
        } else if (documentSnapshot.get('roletype') == RolType.winch) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => WinchHome()));
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  //____________________________________________________________
}
