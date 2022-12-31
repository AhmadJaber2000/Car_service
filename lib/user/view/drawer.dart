import 'dart:math';
import 'package:Car_service/ChatNew/screens/home_screen.dart';
import 'package:Car_service/ContactUs/ContactUs.dart';
import 'package:Car_service/authenticate/service/authenticate.dart';
import 'package:Car_service/authenticate/view/login_screen.dart';
import 'package:Car_service/tools/constants.dart';
import 'package:Car_service/user/view/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../RateThisApp/main.dart';
import '../../authenticate/service/authentication_bloc.dart';
import '../../checkbox/main.dart';
import '../../viewmodel/viewmodel.dart';
import '../../welcome/welcome_screen.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authState == AuthState.unauthenticated) {
          ViewModel.pushAndRemoveUntil(context, const WelcomeScreen(), false);
        }
      },
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff004c4c),
                ),
                child: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 100,
                )),
            ListTile(
              title: const Text(
                'Profile',
                style: TextStyle(color: Color(0xff111111)),
              ),
              leading: Transform.rotate(
                angle: pi / 150,
                child: Icon(
                  Icons.person,
                  color: Color(0xff317873),
                ),
              ),
              onTap: () {
                ViewModel.push(context, const EditProfile());
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: const Text(
                'Chat',
                style: TextStyle(color: Color(0xff111111)),
              ),
              leading: Transform.rotate(
                angle: pi / 150,
                child: Icon(
                  Icons.chat,
                  color: Color(0xff317873),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatWindow()));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: const Text(
                'Rate This App',
                style: TextStyle(color: Color(0xff111111)),
              ),
              leading: Transform.rotate(
                angle: pi / 150,
                child: Icon(
                  Icons.star_rate,
                  color: Color(0xff317873),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RateThisApp()));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: const Text(
                'Contact Us',
                style: TextStyle(color: Color(0xff111111)),
              ),
              leading: Transform.rotate(
                angle: pi / 150,
                child: Icon(
                  Icons.feedback,
                  color: Color(0xff317873),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactPage()));
              },
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(color: primecolor),
              ),
              leading: Transform.rotate(
                angle: pi / 1,
                child: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              onTap: () {
                context.read<AuthenticationBloc>().add(LogoutEvent());
                ViewModel.pushAndRemoveUntil(
                    context, const LoginScreen(), false);
                FireStoreUtils.updateActiveStatus(false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
