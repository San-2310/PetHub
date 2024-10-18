import 'package:flutter/material.dart';
import 'package:manipal_app/screens/health_screen/video_call.dart';

class ChatInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor-Patient Chat'),
        actions: [
          GestureDetector(
            onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoCall()));
            },
            child: Icon(Icons.video_call,size: 30,))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    MessageBubble(
                      message: 'Hello! How can I help you today?',
                      isDoctor: true,
                    ),
                    MessageBubble(
                      message: "Hi Doctor, I've been experiencing headaches lately.",
                      isDoctor: false,
                    ),
                    MessageBubble(
                      message: "I'm sorry to hear that. Can you tell me more about these headaches? When did they start, and how often do you experience them?",
                      isDoctor: true,
                    ),
                    MessageBubble(
                      message: 'They started about a week ago. I get them almost daily, usually in the afternoon.',
                      isDoctor: false,
                    ),
                    MessageBubble(
                      message: 'I see. Are they accompanied by any other symptoms, such as nausea or sensitivity to light?',
                      isDoctor: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  child: Text('Send'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isDoctor;

  MessageBubble({required this.message, required this.isDoctor});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isDoctor ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDoctor ? Colors.lightBlue[100] : Colors.lightGreen[100],
          borderRadius: BorderRadius.circular(5),
        ),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        child: Text(message),
      ),
    );
  }
}