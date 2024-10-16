import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:manipal_app/screens/auth_screens/login.dart';
import 'package:manipal_app/firebase_options.dart';
import 'package:manipal_app/resources/user_provider.dart';
import 'package:manipal_app/screens/splashscreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.light(),
      home: SplashScreen(),
    ),
    );
  }
}

