import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_generator_tutorial/pages/Main_Screen.dart';
import 'package:qr_generator_tutorial/pages/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthProvider extends ChangeNotifier {
  Future<void> initializeUser(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    if (pref.getBool("islog") == true) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    }
  }
}