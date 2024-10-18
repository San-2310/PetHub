// import 'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// class VideoCall extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Zego Video Call',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final _formKey = GlobalKey<FormState>();
//   final _liveIDController = TextEditingController();
//   String _userID = UniqueKey().toString();
//   String _userName = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Zego Video Call'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Your Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _userName = value ?? '';
//                 },
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _liveIDController,
//                 decoration: InputDecoration(labelText: 'Live ID'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a Live ID';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => _joinAsHost(context),
//                 child: Text('Start Call (Host)'),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () => _joinAsAudience(context),
//                 child: Text('Join Call (Audience)'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _joinAsHost(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => CallPage(
//             userID: _userID,
//             userName: _userName,
//             liveID: _liveIDController.text,
//             isHost: true,
//             callID: '1',
//           ),
//         ),
//       );
//     }
//   }

//   void _joinAsAudience(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => CallPage(
//             userID: _userID,
//             userName: _userName,
//             liveID: _liveIDController.text,
//             isHost: false,
//             callID: '1',
//           ),
//         ),
//       );
//     }
//   }
// }

// class CallPage extends StatelessWidget {
//   final String userID;
//   final String userName;
//   final String liveID;
//   final bool isHost;
//   final String callID;

//   CallPage({
//     required this.userID,
//     required this.userName,
//     required this.liveID,
//     required this.isHost,
//     required this.callID
//   });
  

//   @override
//   // Widget build(BuildContext context) {
//   //   return SafeArea(
//   //     child: ZegoUIKitPrebuiltLiveStreaming(
//   //       appID: 1816314356, // Replace with your Zego app ID
//   //       appSign: 'c960b02ecc2d75a529530bfeadffaa5f32ea43e4a31999716b533c477085b854', // Replace with your Zego app sign
//   //       userID: userID,
//   //       userName: userName,
//   //       liveID: liveID,
//   //       config: isHost
//   //           ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
//   //           : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
//   //     ),
//   //   );
//   // }



//   Widget build(BuildContext context) {
//     return ZegoUIKitPrebuiltCall(
//       appID: 1816314356, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
//       appSign: 'c960b02ecc2d75a529530bfeadffaa5f32ea43e4a31999716b533c477085b854', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
//       userID: 'user_id',
//       userName: 'user_name',
//       callID: callID,
//       // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
//       config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
//     );
//   }
// }