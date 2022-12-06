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

  User(
      {this.email = '',
      this.firstName = '',
      this.lastName = '',
      this.userID = '',
      this.lat = 0,
      this.long = 0,
      this.profilePictureURL = '',
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
        long: parsedJson['long'] ?? 0);
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
      'long': long
    };
  }
}
