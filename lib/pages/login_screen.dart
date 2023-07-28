import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qr_generator_tutorial/Controller/api/api_controller.dart';
import 'package:qr_generator_tutorial/pages/Main_Screen.dart';
import 'package:qr_generator_tutorial/pages/RegisterScreen.dart';

import 'package:qr_generator_tutorial/pages/rounded_button.dart';
import 'package:qr_generator_tutorial/ui/Colors.dart';
import 'package:qr_generator_tutorial/ui/style/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Apicontroller apicontroller = Apicontroller();
  final _nicformKey = GlobalKey<FormState>();
  final _passwordformKey = GlobalKey<FormState>();
  final _tpnoformKey = GlobalKey<FormState>();
  final _strretformKey = GlobalKey<FormState>();
  final _cityformKey = GlobalKey<FormState>();
  final _repasswordformKey = GlobalKey<FormState>();

  AutovalidateMode switched = AutovalidateMode.disabled;

  //text field controller
  final nicNumberControlleer = TextEditingController();
  final nameControlleer = TextEditingController();
  final passwordControlleer = TextEditingController();
  final StreetControlleer = TextEditingController();
  final CityControlleer = TextEditingController();
  final repasswordControlleer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyle.primaryColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text('Automated Water',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  )),
              const Text('Despensing  System',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 30.0,
                    color: Kyellow,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(
                height: 90,
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter nic number',
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: white),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Form(
                      key: _nicformKey,
                      autovalidateMode: switched,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'NIC number is required';
                          }
                          final nicRegex = RegExp(r'^\d{9}[vVxX]$');
                          final nicRegexWith12Digits = RegExp(r'^\d{12}$');
                          if (!nicRegex.hasMatch(value) &&
                              !nicRegexWith12Digits.hasMatch(value)) {
                            return 'Invalid NIC number';
                          }

                          return null;
                        },
                        maxLength: 10,
                        controller: nicNumberControlleer,
                        style: const TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20,
                            color: lightText),
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: 'Nic Number',
                          fillColor: inputFieldBackgroundColor,
                          contentPadding: EdgeInsets.all(12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Enter Password',
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: white),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Form(
                      key: _passwordformKey,
                      autovalidateMode: switched,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'password is required';
                          }

                          return null;
                        },
                        maxLength: 10,
                        controller: passwordControlleer,
                        style: const TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20,
                            color: lightText),
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: 'Password ',
                          fillColor: inputFieldBackgroundColor,
                          contentPadding: EdgeInsets.all(12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    RoundedButton(
                      buttonText: 'Login',
                      onPress: () {
                        setState(() {
                          switched = AutovalidateMode.always;
                        });
                        if (_nicformKey.currentState!.validate() &&
                            _passwordformKey.currentState!.validate()) {
                          apicontroller.login(nicNumberControlleer.text,
                              passwordControlleer.text, context);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "Don’t have account?",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      TextSpan(
                          text: " Register",
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ));
                            })
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
