import 'package:Car_service/home/view/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../AdminPage/AdminPage.dart';
import '../model/roleType.dart';
import '../tools/constants.dart';

class ViewModel {
  static void route(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(type: documentSnapshot.get('roletype')),
          ),
        );
        if (documentSnapshot.get('roletype') == RoleType.admin) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AdminRole()));
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  //____________________________________________________________

  static String? validateName(String? value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.isEmpty ?? true) {
      return "Name is required";
    } else if (!regExp.hasMatch(value ?? '')) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  static String? validateMobile(String? value) {
    String pattern = r'(^\+?[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.isEmpty ?? true) {
      return "Mobile phone number is required";
    } else if (!regExp.hasMatch(value ?? '')) {
      return "Mobile phone number must contain only digits";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if ((value?.length ?? 0) < 6) {
      return 'Password must be more than 5 characters';
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value ?? '')) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (password != confirmPassword) {
      return 'Password doesn\'t match';
    } else if (confirmPassword?.isEmpty ?? true) {
      return 'Confirm password is required';
    } else {
      return null;
    }
  }

  static String? chooseType(String? value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.isEmpty ?? true) {
      return "Type is required";
    } else if (!regExp.hasMatch(value ?? '')) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

//helper method to show progress
  static late ProgressDialog progressDialog;

  static showProgress(
      BuildContext context, String message, bool isDismissible) async {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: isDismissible);
    progressDialog.style(
        message: message,
        borderRadius: 10.0,
        backgroundColor: Color(colorPrimary),
        progressWidget: Container(
          padding: const EdgeInsets.all(8.0),
          child: const CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation(Color(colorPrimary)),
          ),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: const TextStyle(
            color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.w600));
    await progressDialog.show();
  }

  static updateProgress(String message) {
    progressDialog.update(message: message);
  }

  static hideProgress() async {
    await progressDialog.hide();
  }

//helper method to show alert dialog
  static showAlertDialog(BuildContext context, String title, String content) {
    // set up the AlertDialog
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static pushReplacement(BuildContext context, Widget destination) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => destination));
  }

  static push(BuildContext context, Widget destination) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => destination));
  }

  static pushAndRemoveUntil(
      BuildContext context, Widget destination, bool predict) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => destination,
        ),
        (Route<dynamic> route) => predict);
  }

  Widget displayCircleImage(String picUrl, double size, hasBorder) =>
      CachedNetworkImage(
          imageBuilder: (context, imageProvider) =>
              _getCircularImageProvider(imageProvider, size, false),
          imageUrl: picUrl,
          placeholder: (context, url) =>
              _getPlaceholderOrErrorImage(size, hasBorder),
          errorWidget: (context, url, error) =>
              _getPlaceholderOrErrorImage(size, hasBorder));

  Widget _getPlaceholderOrErrorImage(double size, hasBorder) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color(0xff7c94b6),
          borderRadius: BorderRadius.all(Radius.circular(size / 2)),
          border: Border.all(
            color: Colors.white,
            width: hasBorder ? 2.0 : 0.0,
          ),
        ),
        child: ClipOval(
            child: Image.asset(
          'assets/images/placeholder.jpg',
          fit: BoxFit.cover,
          height: size,
          width: size,
        )),
      );

  Widget _getCircularImageProvider(
      ImageProvider provider, double size, bool hasBorder) {
    return ClipOval(
        child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(size / 2)),
          border: Border.all(
            color: Colors.white,
            style: hasBorder ? BorderStyle.solid : BorderStyle.none,
            width: 1.0,
          ),
          image: DecorationImage(
            image: provider,
            fit: BoxFit.cover,
          )),
    ));
  }

  static bool isDarkMode(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return false;
    } else {
      return true;
    }
  }

  static InputDecoration getInputDecoration(
      {required String hint,
      required bool darkMode,
      required Color errorColor}) {
    return InputDecoration(
      constraints: const BoxConstraints(maxWidth: 720, minWidth: 200),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      fillColor: darkMode ? Colors.black54 : Colors.white,
      hintText: hint,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: Color(colorPrimary), width: 2.0)),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: errorColor),
        borderRadius: BorderRadius.circular(25.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: errorColor),
        borderRadius: BorderRadius.circular(25.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(25.0),
      ),
    );
  }

  static showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }
}