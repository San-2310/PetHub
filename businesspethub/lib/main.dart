import 'package:businesspethub/constants/global_variables.dart';
import 'package:businesspethub/features/admin/screens/admin_screen.dart';
import 'package:businesspethub/features/auth/screens/auth_screen.dart';
import 'package:businesspethub/features/auth/services/auth_service.dart';
import 'package:businesspethub/features/home/screens/home_screen.dart';
import 'package:businesspethub/providers/user_provider.dart';
import 'package:businesspethub/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PetHub',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          if (userProvider.user.token.isNotEmpty) {
            return userProvider.user.type == 'user'
                ? const HomeScreen()
                : const AdminScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}