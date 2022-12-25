import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyAppssssss());
}

class MyAppssssss extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Leave a Comment'),
        ),
        body: LeaveCommentForm(),
      ),
    );
  }
}

class LeaveCommentForm extends StatefulWidget {
  @override
  _LeaveCommentFormState createState() => _LeaveCommentFormState();
}

class _LeaveCommentFormState extends State<LeaveCommentForm> {
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _commentController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your comment',
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              // Add a new document to the comments collection
              await FirebaseFirestore.instance.collection('comments').add({
                'text': _commentController.text,
                'timestamp': Timestamp.now(),
              });
              _commentController.clear();
            },
            child: Text('ok'),
          ),
          SizedBox(height: 16),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('comments')
                .orderBy('timestamp')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();

              return Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    return ListTile(
                      title: Text(document['text']),
                      subtitle: Text(document['timestamp'].toDate().toString()),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
