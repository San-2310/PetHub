import 'package:flutter/material.dart';
import 'package:manipal_app/components/app_drawer.dart';
import 'package:manipal_app/screens/adopt_pets/chatbot_screen.dart';

class PetAdoptScreen extends StatelessWidget {
  const PetAdoptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adopt Pet"),
      ),
      drawer: AppDrawer(currentRoute: '/adopt_pet'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child:Column(children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatbotScreen()));
            }, child: Text('Chatbot'))
          ],)
        ),
      ),
    );
  }
}