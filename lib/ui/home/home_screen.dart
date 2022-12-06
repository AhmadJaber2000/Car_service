import 'dart:math';
import 'package:Car_service/services/helper.dart';
import 'package:Car_service/ui/User_cart/UserCart.dart';
import 'package:Car_service/ui/auth/authentication_bloc.dart';
import 'package:Car_service/ui/auth/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'UserPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  ////late User user;

  @override
  void initState() {
    super.initState();
    ////user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authState == AuthState.unauthenticated) {
          pushAndRemoveUntil(context, const WelcomeScreen(), false);
        }
      },
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff000000),
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(color: Color(0xffd3a625)),
                ),
              ),
              ListTile(
                title: Text(
                  'Rate Us',
                  style: TextStyle(
                      color: isDarkMode(context)
                          ? Colors.grey.shade50
                          : Colors.grey.shade900),
                ),
                leading: Transform.rotate(
                  angle: pi / 150,
                  child: Icon(
                    Icons.star_rate,
                    color: Color(0xffd3a625),
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(
                      color: isDarkMode(context)
                          ? Colors.grey.shade50
                          : Colors.grey.shade900),
                ),
                leading: Transform.rotate(
                  angle: pi / 1,
                  child: Icon(
                    Icons.exit_to_app,
                    color: Color(0xffd3a625),
                  ),
                ),
                onTap: () {
                  context.read<AuthenticationBloc>().add(LogoutEvent());
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            'User Home',
            style: TextStyle(color: Color(0xffd3a625)),
          ),
          iconTheme: IconThemeData(color: Color(0xffd3a625)),
          backgroundColor: Color(0xff000000),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0), //70
                      decoration: BoxDecoration(
                        color: Color(0xffd3a625),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: usercard.length,
                      itemBuilder: (context, index) => UserPage(
                        itemindex: index,
                        userCart: usercard[index],
                        press: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
