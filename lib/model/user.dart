import 'dart:io';
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
  String lastActive;
  String pushToken;
  String about;
  String createdAt;

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
      this.long = 0,
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
    };
  }
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
