import 'package:business_app/doctor_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientListScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patients')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('chats').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var patients = snapshot.data!.docs
              .map((doc) => doc['doctorId'] as String)
              .toSet()
              .toList();

          return ListView.builder(
            itemCount: patients.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Patient ${index + 1}'),
                subtitle: Text('Doctor: ${patients[index]}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorChatScreen(doctorName: patients[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}