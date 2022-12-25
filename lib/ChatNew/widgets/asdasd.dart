import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(gggggggggggggg());

class gggggggggggggg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: firestore.collection('comments').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot comment = snapshot.data!.docs[index];
                    return Text(comment['text']);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Enter a comment',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await firestore.collection('Comments').add({
                'text': _commentController.text,
                'userId': '123',
                'timestamp': FieldValue.serverTimestamp(),
              });
              _commentController.clear();
            },
            child: Text('Post Comment'),
          ),
        ],
      ),
    );
  }
}
