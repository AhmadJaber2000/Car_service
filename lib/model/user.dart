import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User {
  String email;

  String firstName;

  String lastName;

  String userID;

  String profilePictureURL;

  String appIdentifier;

  String roletype;

  double lat;

  double long;

  double rate;

  String phoneNumber;

  bool isOnline;
  bool activestate;
  String lastActive;
  String pushToken;
  String about;
  String createdAt;
  double rateSum;

  User(
      {this.email = '',
      this.about = '',
      this.pushToken = '',
      this.lastActive = '',
      this.createdAt = '',
      this.isOnline = false,
      this.firstName = '',
      this.lastName = '',
      this.userID = '',
      this.lat = 0,
      this.activestate = false,
      this.long = 0,
      this.rateSum = 0,
      this.profilePictureURL = '',
      this.rate = 0,
      this.phoneNumber = '',
      this.roletype = ''})
      : appIdentifier =
            'Flutter Login Screen ${kIsWeb ? 'Web' : Platform.operatingSystem}';

  String fullName() => '$firstName $lastName';

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      email: parsedJson['email'] ?? '',
      firstName: parsedJson['firstName'] ?? '',
      lastName: parsedJson['lastName'] ?? '',
      userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
      profilePictureURL: parsedJson['profilePictureURL'] ?? '',
      roletype: parsedJson['roletype'] ?? '',
      lat: parsedJson['lat'] ?? 0,
      rate: parsedJson['rate'] ?? 0,
      phoneNumber: parsedJson['phoneNumber'] ?? 0,
      long: parsedJson['long'] ?? 0,
      about: parsedJson['about'] ?? '',
      isOnline: parsedJson['is_online'] ?? false,
      lastActive: parsedJson['last_active'] ?? '',
      pushToken: parsedJson['push_token'] ?? '',
      createdAt: parsedJson['created_at'] ?? '',
      activestate: parsedJson["activestate"] ?? false,
      rateSum: parsedJson["rateSum"] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'id': userID,
      'profilePictureURL': profilePictureURL,
      'appIdentifier': appIdentifier,
      'roletype': roletype,
      'lat': lat,
      'long': long,
      'rate': rate,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'about': about,
      'created_at': createdAt,
      'last_active': lastActive,
      'push_token': pushToken,
      "activestate": activestate,
      'rateSum': rateSum,
    };
  }

//   Map<String, dynamic> commentitem(String comment) {
//     return {
//       'Comment': FieldValue.arrayUnion([
//         {
//           'data': DateTime.now(),
//           'comment': comment,
//         }
//       ])
//     };
//   }
}

// class Messages {
//   String messages;
//   String sent_by;
//   String last_message;
//
//   DateTime datetime;

//   Messages({
//     this.messages = '',
//     this.sent_by = '',
//     this.last_message = '',
//     required this.datetime,
//   });
//
//   factory Messages.fromJson(Map<String, dynamic> parsedJson) {
//     return Messages(
//       messages: parsedJson['messages'] ?? '',
//       sent_by: parsedJson['sent_by'] ?? '',
//       last_message: parsedJson['last_message'] ?? '',
//       datetime: DateTime.now(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'messages': messages,
//       'sent_by': sent_by,
//       'last_message': last_message,
//       'datetime': DateTime.now(),
//     };
//   }
// }
