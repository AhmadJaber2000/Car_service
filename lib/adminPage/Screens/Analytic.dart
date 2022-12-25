import 'package:Car_service/tools/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class commentMange extends StatefulWidget {
  const commentMange({Key? key}) : super(key: key);

  @override
  State<commentMange> createState() => _commentMangeState();
}

final _commentController = TextEditingController();

class _commentMangeState extends State<commentMange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment Manage'),
        backgroundColor: primecolor,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('comments').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();

                return Expanded(
                  child: ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(5),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];

                      return Card(
                        child: GestureDetector(
                          child: ListTile(
                            title: Text(document['userId']),
                            subtitle: Text(document['text'].toString()),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
