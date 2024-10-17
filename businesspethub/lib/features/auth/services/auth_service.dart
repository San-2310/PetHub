import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:businesspethub/models/user.dart';
import 'package:businesspethub/providers/user_provider.dart';
import 'package:businesspethub/constants/utils.dart';
import 'package:businesspethub/common/widgets/bottom_bar.dart';

class AuthService {
  final String uri =
      'https://095a-2409-40c0-105f-b7a7-2044-3789-252d-bc18.ngrok-free.app';

  bool isEmailValid(String email) {
    return email.contains('@');
  }

  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    String? name, // Name can now be null
    required String username,
    required String fullname,
    required String contactnumber,
  }) async {
    if (!isEmailValid(email)) {
      showSnackBar(context, 'Please enter a valid email.');
      return;
    }

    try {
      User user = User(
        id: '',
        name: name != null && name.isNotEmpty
            ? name
            : username, // Use username if name is null or empty
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
        cart: [],
        username: username,
        fullname: fullname,
        contactnumber: contactnumber,
        photoUrl: null,
        pets: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (res.statusCode == 200) {
        showSnackBar(
            context, 'Account created! Login with the same credentials!');
      } else {
        showSnackBar(context, 'Error: ${res.body}');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (!isEmailValid(email)) {
      showSnackBar(context, 'Please enter a valid email.');
      return;
    }

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (res.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Provider.of<UserProvider>(context, listen: false).setUser(res.body);
        await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        Navigator.pushNamedAndRemoveUntil(
            context, BottomBar.routeName, (route) => false);
      } else {
        showSnackBar(context, 'Error: ${res.body}');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        return;
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      if (jsonDecode(tokenRes.body) == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        Provider.of<UserProvider>(context, listen: false).setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
