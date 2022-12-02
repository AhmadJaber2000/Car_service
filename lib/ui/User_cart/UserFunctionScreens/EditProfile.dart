import 'package:Car_service/model/user.dart';
import 'package:Car_service/ui/User_cart/UserFunctionScreens/UsersFunctionScreensUI/EditProfileUi.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffcfc),
      appBar: HomeAppBar(),
      body: AccountDetails(
        user: User(),
      ),
    );
  }

  AppBar HomeAppBar() {
    return AppBar(
      backgroundColor: Color(0xff0b421a),
      title: Text(
        "Edit Profile",
        style: TextStyle(color: Color(0xffeac784)),
      ),
      centerTitle: true,
    );
  }
}
