import 'package:Car_service/authenticate/service/authenticate.dart';
import 'package:flutter/material.dart';
import 'model/user.dart';

class ListUser extends StatefulWidget {
  const ListUser({Key? key, required this.type}) : super(key: key);
  final String type;
  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  List<User> users = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    functions();
  }

  functions() async {
    users = await FireStoreUtils.getMarchantsLocation(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('List'),
      ),
      body: FutureBuilder(
          future: FireStoreUtils.getMarchantsLocation(widget.type),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something has erorr");
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              return ListView(
                children: users.map(buildUser).toList(),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Widget buildUser(User user) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      margin: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Colors.cyan,
            ],
          )),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.fullName(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            const Icon(
              Icons.add_call,
              color: Colors.cyan,
              size: 20,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(" Rate : ${user.rate}",
                style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 30,
                    fontWeight: FontWeight.bold))
            // Image.asset(
            //   user.email,
            //   height: 100,
            // ),
          ],
        ),
      ]),
    );
  }
}
