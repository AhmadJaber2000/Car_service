import 'package:flutter/material.dart';

import '../../Constants.dart';
import '../../Firebase/auth.dart';
import '../../components/cardbtn.dart';
import 'components/urlogohere.dart';

class AdminRole extends StatelessWidget {
  const AdminRole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: kappbartxt,
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: ksecondColor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => {Navigator.pushNamed(context, '/add')},
                    child: const cardbtn(
                      txt: "Manage",
                      icon: Icons.manage_accounts,
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      //do smthing
                      Navigator.pushNamed(context, "/edit")
                    },
                    child: const cardbtn(
                      txt: "Edit",
                      icon: Icons.edit,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => {
                      //do smthing
                    },
                    child: const cardbtn(
                      txt: "Analytics",
                      icon: Icons.analytics_rounded,
                    ),
                  ),
                  InkWell(
                    onTap: () async => {
                      await Auth().signout(),
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (route) => false)
                      //do another db thing
                    },
                    child: const cardbtn(
                      txt: "Logout",
                      icon: Icons.data_usage_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const urlogohere()
            ],
          ),
        ),
      ),
    );
  }
}
