import 'package:flutter/material.dart';
import 'package:manipal_app/components/app_drawer.dart';

class InsuranceScreen extends StatelessWidget {
  const InsuranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet Travel"),
      ),
      drawer: AppDrawer(currentRoute: '/insurance'),
    );
  }
}