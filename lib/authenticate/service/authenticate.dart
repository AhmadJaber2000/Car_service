import 'dart:developer';
import 'dart:io';

import 'package:Car_service/model/roleType.dart';
import 'package:Car_service/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart' as apple;
import '../../ChatIn/models/message.dart';
import '../../ChatNew/models/message.dart';
import '../../tools/constants.dart';
import '../../viewmodel/viewmodel.dart';

class FireStoreUtils {
  final CollectionReference usercol =
      FirebaseFirestore.instance.collection(usersCollection);
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Reference storage = FirebaseStorage.instance.ref();
  final CollectionReference vehiculecol =
      FirebaseFirestore.instance.collection(usersCollection);
  static FirebaseStorage storageimage = FirebaseStorage.instance;
  static auth.FirebaseAuth authentication = auth.FirebaseAuth.instance;

  static late User me;

  static Future<User?> getCurrentUser(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await firestore.collection(usersCollection).doc(uid).get();
    if (userDocument.data() != null && userDocument.exists) {
      return User.fromJson(userDocument.data()!);
    } else {
      return null;
    }
  }

  static auth.User? get user => auth.FirebaseAuth.instance.currentUser;

  static Future<User> updateCurrentUser(User user) async {
    return await firestore
        .collection(usersCollection)
        .doc(user.userID)
        .set(user.toJson())
        .then((document) {
      return user;
    });
  }

  // static Future<void> getSelfInfo() async {
  //   await firestore
  //       .collection(usersCollection)
  //       .doc(user!.uid)
  //       .get()
  //       .then((user) async {
  //     me = User.fromJson(user.data()!);
  //     log('My Data: ${user.data()}');
  //   });
  // }

  // static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
  //   return firestore
  //       .collection(usersCollection)
  //       .where('userID', isNotEqualTo: user!.uid)
  //       .snapshots();
  // }

  static Future<String> uploadUserImageToServer(
      Uint8List imageData, String userID) async {
    Reference upload = storage.child("images/$userID.png");
    UploadTask uploadTask =
        upload.putData(imageData, SettableMetadata(contentType: 'image/jpeg'));
    var downloadUrl =
        await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    return downloadUrl.toString();
  }

  /// login with email and password and userType with firebase
  /// @param email user email
  /// @param password user password
  /// @param userType User userType
  static Future<dynamic> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      auth.UserCredential result = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await firestore
          .collection(usersCollection)
          .doc(result.user?.uid ?? '')
          .get();
      User? user;
      if (documentSnapshot.exists) {
        user = User.fromJson(documentSnapshot.data() ?? {});
      }
      return user;
    } on auth.FirebaseAuthException catch (exception, s) {
      debugPrint('$exception$s');
      switch ((exception).code) {
        case 'invalid-email':
          return 'Email address is malformed.';
        case 'wrong-password':
          return 'Wrong password.';
        case 'user-not-found':
          return 'No user corresponding to the given email address.';
        case 'user-disabled':
          return 'This user has been disabled.';
        case 'too-many-requests':
          return 'Too many attempts to sign in as this user.';
      }
      return 'Unexpected firebase error, Please try again.';
    } catch (e, s) {
      debugPrint('$e$s');
      return 'Login failed, Please try again.';
    }
  }

  static Future<List<User>> getMarchantsLocation(String type) async {
    List<User> users = [];
    print("type $type");
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(usersCollection)
        .where('roletype', isEqualTo: type)
        .orderBy('rate', descending: true)
        .get();
    print("LENGTH getMarchantsLocation ${querySnapshot.docs.length}");
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      print("rate ${a.get("rate")}");
      users.add(await User(
          firstName: a.get("firstName"),
          lastName: a.get("lastName"),
          email: a.get("email"),
          lat: a.get("lat"),
          long: a.get("long"),
          roletype: a.get("roletype"),
          rate: a.get("rate"),
          phoneNumber: a.get('phoneNumber'),
          userID: a.get('id')));
    }
    return users;
  }

  static Future<List<User>> getMarchantsRate(String type) async {
    List<User> users = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(usersCollection)
        // .where('roletype', isEqualTo: type)
        .where('rate', isGreaterThanOrEqualTo: 3)
        .get();
    print("LENGTH getMarchantsRate ${querySnapshot.docs.length}");
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      print("rate ${a.get("rate")}");
      print("roletype ${a.get("roletype")}");
      if (a.get("roletype") == "Track") {
        users.add(await User(
            firstName: a.get("firstName"),
            lastName: a.get("lastName"),
            lat: a.get("lat"),
            long: a.get("long"),
            roletype: a.get("roletype"),
            rate: a.get("rate"),
            phoneNumber: a.get("phoneNumber"),
            userID: a.get('id')));
      }
    }
    return users;
  }

  getUser() async {
    QuerySnapshot snapshot =
        await usercol.where('roletype', isEqualTo: 'Mechanic').get();
    snapshot.docs.forEach((DocumentSnapshot doc) {
      print(doc.data());
    });
  }

  static loginWithFacebook() async {
    FacebookAuth facebookAuth = FacebookAuth.instance;
    bool isLogged = await facebookAuth.accessToken != null;
    if (!isLogged) {
      LoginResult result = await facebookAuth
          .login(); // by default we request the email and the public profile
      if (result.status == LoginStatus.success) {
        // you are logged
        AccessToken? token = await facebookAuth.accessToken;
        return await handleFacebookLogin(
            await facebookAuth.getUserData(), token!);
      }
    } else {
      AccessToken? token = await facebookAuth.accessToken;
      return await handleFacebookLogin(
          await facebookAuth.getUserData(), token!);
    }
  }

  static handleFacebookLogin(
      Map<String, dynamic> userData, AccessToken token) async {
    auth.UserCredential authResult = await auth.FirebaseAuth.instance
        .signInWithCredential(
            auth.FacebookAuthProvider.credential(token.token));
    User? user = await getCurrentUser(authResult.user?.uid ?? '');
    List<String> fullName = (userData['name'] as String).split(' ');
    String firstName = '';
    String lastName = '';
    if (fullName.isNotEmpty) {
      firstName = fullName.first;
      lastName = fullName.skip(1).join(' ');
    }

    if (user != null) {
      user.profilePictureURL = userData['picture']['data']['url'];
      user.firstName = firstName;
      user.lastName = lastName;
      user.email = userData['email'];
      dynamic result = await updateCurrentUser(user);
      return result;
    } else {
      user = User(
        email: userData['email'] ?? '',
        firstName: firstName,
        lastName: lastName,
        profilePictureURL: userData['picture']['data']['url'] ?? '',
        userID: authResult.user?.uid ?? '',
      );
      String? errorMessage = await createNewUser(user);
      if (errorMessage == null) {
        return user;
      } else {
        return errorMessage;
      }
    }
  }

  /// save a new user document in the USERS table in firebase firestore
  /// returns an error message on failure or null on success
  static Future<String?> createNewUser(User user) async => await firestore
      .collection(usersCollection)
      .doc(user.userID)
      .set(user.toJson())
      .then((value) => null, onError: (e) => e);

  static signUpWithEmailAndPassword(
      {required String emailAddress,
      required String password,
      userType = 'userType',
      Uint8List? imageData,
      double? lat,
      double? long,
      firstName = 'Anonymous',
      double? rate,
      String? phonenumber,
      lastName = 'User'}) async {
    try {
      auth.UserCredential result = await auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);
      String profilePicUrl = '';
      if (imageData != null) {
        ViewModel.updateProgress('Uploading image, Please wait...');
        profilePicUrl =
            await uploadUserImageToServer(imageData, result.user?.uid ?? '');
      }
      User user = User(
          email: emailAddress,
          firstName: firstName,
          userID: result.user?.uid ?? '',
          lastName: lastName,
          roletype: userType,
          lat: lat!,
          long: long!,
          rate: rate!,
          phoneNumber: phonenumber!,
          profilePictureURL: profilePicUrl);

      String? errorMessage = await createNewUser(user);
      if (errorMessage == null) {
        return user;
      } else {
        return 'Couldn\'t sign up for firebase, Please try again.';
      }
    } on auth.FirebaseAuthException catch (error) {
      debugPrint('$error${error.stackTrace}');
      String message = 'Couldn\'t sign up';
      switch (error.code) {
        case 'email-already-in-use':
          message = 'Email already in use, Please pick another email!';
          break;
        case 'invalid-email':
          message = 'Enter valid e-mail';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled';
          break;
        case 'weak-password':
          message = 'Password must be more than 5 characters';
          break;
        case 'too-many-requests':
          message = 'Too many requests, Please try again later.';
          break;
      }
      return message;
    } catch (e, s) {
      debugPrint('FireStoreUtils.signUpWithEmailAndPassword $e $s');
      return 'Couldn\'t sign up';
    }
  }

  static logout() async {
    await auth.FirebaseAuth.instance.signOut();
  }

  static Future<User?> getAuthUser() async {
    auth.User? firebaseUser = auth.FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      User? user = await getCurrentUser(firebaseUser.uid);
      return user;
    } else {
      return null;
    }
  }

  static Future<dynamic> loginOrCreateUserWithPhoneNumberCredential({
    required auth.PhoneAuthCredential credential,
    required String phoneNumber,
    String? firstName = 'Anonymous',
    String? lastName = 'User',
    Uint8List? imageData,
  }) async {
    auth.UserCredential userCredential =
        await auth.FirebaseAuth.instance.signInWithCredential(credential);
    User? user = await getCurrentUser(userCredential.user?.uid ?? '');
    if (user != null) {
      return user;
    } else {
      /// create a new user from phone login
      String profileImageUrl = '';
      if (imageData != null) {
        profileImageUrl = await uploadUserImageToServer(
            imageData, userCredential.user?.uid ?? '');
      }
      User user = User(
          firstName:
              firstName!.trim().isNotEmpty ? firstName.trim() : 'Anonymous',
          lastName: lastName!.trim().isNotEmpty ? lastName.trim() : 'User',
          email: '',
          profilePictureURL: profileImageUrl,
          userID: userCredential.user?.uid ?? '');
      String? errorMessage = await createNewUser(user);
      if (errorMessage == null) {
        return user;
      } else {
        return 'Couldn\'t create new user with phone number.';
      }
    }
  }

  static loginWithApple() async {
    final appleCredential = await apple.TheAppleSignIn.performRequests([
      const apple.AppleIdRequest(
          requestedScopes: [apple.Scope.email, apple.Scope.fullName])
    ]);
    if (appleCredential.error != null) {
      return 'Couldn\'t login with apple.';
    }

    if (appleCredential.status == apple.AuthorizationStatus.authorized) {
      final auth.AuthCredential credential =
          auth.OAuthProvider('apple.com').credential(
        accessToken: String.fromCharCodes(
            appleCredential.credential?.authorizationCode ?? []),
        idToken: String.fromCharCodes(
            appleCredential.credential?.identityToken ?? []),
      );
      return await handleAppleLogin(credential, appleCredential.credential!);
    } else {
      return 'Couldn\'t login with apple.';
    }
  }

  static handleAppleLogin(
    auth.AuthCredential credential,
    apple.AppleIdCredential appleIdCredential,
  ) async {
    auth.UserCredential authResult =
        await auth.FirebaseAuth.instance.signInWithCredential(credential);
    User? user = await getCurrentUser(authResult.user?.uid ?? '');
    if (user != null) {
      return user;
    } else {
      user = User(
        email: appleIdCredential.email ?? '',
        firstName: appleIdCredential.fullName?.givenName ?? '',
        profilePictureURL: '',
        userID: authResult.user?.uid ?? '',
        lastName: appleIdCredential.fullName?.familyName ?? '',
      );
      String? errorMessage = await createNewUser(user);
      if (errorMessage == null) {
        return user;
      } else {
        return errorMessage;
      }
    }
  }

  static resetPassword(String emailAddress) async =>
      await auth.FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailAddress);

  static Future<bool> userExists() async {
    return (await firestore.collection("User").doc(user!.uid).get()).exists;
  }

  // for getting current user info
  static Future<void> getSelfInfo() async {
    await firestore.collection('User').doc(user!.uid).get().then((user) async {
      if (user.exists) {
        me = User.fromJson(user.data()!);
        log('My Data: ${user.data()}');
      }
    });
  }

  // for creating a new user
  // static Future<void> createUser() async {
  //   final time = DateTime.now().millisecondsSinceEpoch.toString();
  //
  //   final User = ChatUser(
  //       id: user.uid,
  //       name: user.displayName.toString(),
  //       email: user.email.toString(),
  //       about: "Hey, I'm using We Chat!",
  //       image: user.photoURL.toString(),
  //       createdAt: time,
  //       isOnline: false,
  //       lastActive: time,
  //       pushToken: '');
  //
  //   return await firestore
  //       .collection('users')
  //       .doc(user.uid)
  //       .set(chatUser.toJson());
  // }

  // for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('User')
        .where('id', isNotEqualTo: user!.uid)
        .snapshots();
  }

  // for updating user information
  // static Future<void> updateUserInfo() async {
  //   await firestore.collection('users').doc(user.uid).update({
  //     'name': me.name,
  //     'about': me.about,
  //   });
  // }

  // update profile picture of user
  static Future<void> updateProfilePicture(File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    log('Extension: $ext');

    //storage file ref with path
    final ref = storageimage.ref().child('profile_pictures/${user!.uid}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    me.profilePictureURL = await ref.getDownloadURL();
    await firestore
        .collection(usersCollection)
        .doc(user!.uid)
        .update({'profilePictureURL': me.profilePictureURL});
  }

  // for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(User user) {
    return firestore
        .collection('User')
        .where('id', isEqualTo: user.userID)
        .snapshots();
  }

  // update online or last active status of user
  static Future<void> updateActiveStatus(bool isOnline) async {
    firestore.collection('User').doc(user!.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString()
    });
  }

  ///************** Chat Screen Related APIs **************

  // chats (collection) --> conversation_id (doc) --> messages (collection) --> message (doc)

  // useful for getting conversation id
  static String getConversationID(String id) =>
      user!.uid.hashCode <= id.hashCode
          ? '${user!.uid}_$id'
          : '${id}_${user!.uid}';

  // for getting all messages of a specific conversation from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(User user) {
    return firestore
        .collection('chats/${getConversationID(user.userID)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  // for sending message
  static Future<void> sendMessage(User chatUser, String msg, Type type) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message = Message(
        toId: chatUser.userID,
        msg: msg,
        read: '',
        type: type,
        fromId: user!.uid,
        sent: time);

    final ref = firestore
        .collection('chats/${getConversationID(chatUser.userID)}/messages/');
    await ref.doc(time).set(message.toJson());
  }

  //update read status of message
  static Future<void> updateMessageReadStatus(Message message) async {
    firestore
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  //get only last message of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(User user) {
    return firestore
        .collection('chats/${getConversationID(user.userID)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //send chat image
  static Future<void> sendChatImage(User chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = storageimage.ref().child(
        'images/${getConversationID(chatUser.userID)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }
}
