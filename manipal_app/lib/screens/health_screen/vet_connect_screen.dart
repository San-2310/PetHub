import 'package:flutter/material.dart';
import 'package:manipal_app/components/doctor_card.dart';
import 'package:manipal_app/models/vet.dart';

class VetConnectScreen extends StatelessWidget {
  const VetConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: Text('Doctors')),
    //   body: ListView.builder(
    //     itemCount: doctorsList.length,
    //     itemBuilder: (context, index) {
    //       return Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    //         child: DoctorCard(doctor: doctorsList[index]),
    //       );
    //     },
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: doctorsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: DoctorCard(doctor: doctorsList[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}


