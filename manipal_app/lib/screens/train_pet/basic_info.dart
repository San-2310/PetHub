import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manipal_app/screens/train_pet/video_player.dart';

class basicInfo extends StatelessWidget{
  const basicInfo({super.key});

  @override
  Widget build(context)
  {
    return Scaffold(
      body: ElevatedButton(
        onPressed: (){
          Navigator.push(context, 
              MaterialPageRoute(builder: (context)=>VideoPlayer()));
        },
        child: Center(child: Text('Start Video')),
      )
    );
  }
}