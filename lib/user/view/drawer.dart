import 'dart:math';
import 'package:Car_service/authenticate/view/login_screen.dart';
import 'package:Car_service/user/view/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../authenticate/service/authentication_bloc.dart';
import '../../viewmodel/viewmodel.dart';
import '../../welcome/welcome_screen.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

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
                  color: Theme.of(context).primaryColorLight,
                ),
                child: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 100,
                )),
            ListTile(
              title: const Text(
                'Profile',
                style: TextStyle(color: Colors.cyan),
              ),
              leading: Transform.rotate(
                angle: pi / 150,
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColorLight,
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
                'Logout',
                style: TextStyle(color: Colors.cyan),
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
