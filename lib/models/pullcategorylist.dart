import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreExample extends StatefulWidget {
  @override
  _FirestoreExampleState createState() => _FirestoreExampleState();
}

class _FirestoreExampleState extends State<FirestoreExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Example'),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Danhmucsanpham').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

                if (data == null || data['field_name'] == null) {
                  return SizedBox(); // Hoặc Widget tương tự
                }

                String fieldData = data['field_name'] as String;

                String documentId = document.id;

                return ListTile(
                  title: Text(fieldData),
                  subtitle: Text(documentId),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
