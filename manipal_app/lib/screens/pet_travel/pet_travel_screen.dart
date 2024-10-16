import 'package:flutter/material.dart';
import 'package:manipal_app/components/app_drawer.dart';

class PetTravelScreen extends StatelessWidget {
  const PetTravelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet Travel"),
      ),
      drawer: AppDrawer(currentRoute: '/pet_travel'),
    );
  }
}