import 'package:flutter/material.dart';
import 'package:manipal_app/components/utils.dart';
import 'package:manipal_app/screens/health_screen/symptoms_screen.dart';
import 'package:manipal_app/screens/health_screen/vet_connect_screen.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health'),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(251, 233, 233, 0.85),
                    borderRadius: BorderRadius.circular(25)),
                child: Image.asset(
                  'assets/svg/pet_health.png',
                  height: 180,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VetConnectScreen()));
                  },
                  child: rectangularGreenBox("Direct Consultancy with Vet")),
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(251, 233, 233, 0.85),
                    borderRadius: BorderRadius.circular(25)),
                child: Image.asset(
                  'assets/svg/pet_health.png',
                  height: 180,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SymptomsScreen()));
                },
                child: rectangularGreenBox('Symptoms')),
            ],
          ),
        ),
      ),
    );
  }
}
