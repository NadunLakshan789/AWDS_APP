import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_generator_tutorial/pages/QrGenaratePage.dart';
import 'package:qr_generator_tutorial/pages/login_screen.dart';
import 'package:qr_generator_tutorial/provider/Authprovider.dart';
import 'package:qr_generator_tutorial/ui/Colors.dart';
import 'package:qr_generator_tutorial/ui/style/style.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen();

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Provider.of<AuthProvider>(context, listen: false).initializeUser(context);
    });

    return Scaffold(
      backgroundColor: AppStyle.primaryColor,
      body: Center(
        child: Center(child: AppNameWidget()),
      ),
    );
  }
}

class AppNameWidget extends StatelessWidget {
  const AppNameWidget();

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        children: const [
          Text('AWDS',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 30.0,
                color: Kyellow,
                fontWeight: FontWeight.w600,
              )),
          SizedBox(
            height: 20,
          ),
          Text('Automated Water',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              )),
          Text('Despensing System',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 30.0,
                color: Kyellow,
                fontWeight: FontWeight.w700,
              ))
        ],
      ),
    );
  }
}
