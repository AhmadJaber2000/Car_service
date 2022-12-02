import 'package:Car_service/model/user.dart';
import 'package:flutter/material.dart';
import 'EditProfiledetails.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  late User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class AccountDetails extends StatelessWidget {
  const AccountDetails({Key? key, required this.user}) : super(key: key);
  final User user;
  // not real number :)
  static const location = "Zarqa, Jordan";
  static const phone = "0780000000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffcfc),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/placeholder.jpg'),
            ),
            Text(
              "Name : " + user.fullName(),
              style: TextStyle(
                  fontSize: 30,
                  color: Color(0xff362415),
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Source Sans Pro"),
            ),
            SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.black,
              ),
            ),
            InfoCard(text: phone, icon: Icons.phone, onPressed: () async {}),
            InfoCard(
                text: location,
                icon: Icons.location_city,
                onPressed: () async {}),
            InfoCard(
                text: user.email, icon: Icons.email, onPressed: () async {}),
          ],
        ),
      ),
    );
  }
}
