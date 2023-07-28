import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:qr_generator_tutorial/Controller/api/api_controller.dart';
import 'package:qr_generator_tutorial/pages/login_screen.dart';
import 'package:qr_generator_tutorial/pages/rounded_button.dart';
import 'package:qr_generator_tutorial/provider/Authprovider.dart';
import 'package:qr_generator_tutorial/ui/Colors.dart';
import 'package:qr_generator_tutorial/ui/style/style.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Apicontroller apicontroller = Apicontroller();
  final _nicformKey = GlobalKey<FormState>();
  final _nameformKey = GlobalKey<FormState>();
  final _tpnoformKey = GlobalKey<FormState>();
  final _strretformKey = GlobalKey<FormState>();
  final _passwordformKey = GlobalKey<FormState>();
  final _repasswordformKey = GlobalKey<FormState>();
  final _cityformKey = GlobalKey<FormState>();
  final nicNumberControlleer = TextEditingController();
  final nameControlleer = TextEditingController();
  final strrtControlleer = TextEditingController();
  final tpnoControlleer = TextEditingController();
  AutovalidateMode switched = AutovalidateMode.disabled;
  final passwordControlleer = TextEditingController();
  final repasswordControlleer = TextEditingController();
  final cityControlleer = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyle.primaryColor,
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Text('Automated Water',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            const Center(
              child: Text('Despensing  System',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 30.0,
                    color: Kyellow,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      height: 10,
                    ),
                    const Text(
                      'Enter Name',
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _nameformKey,
                      autovalidateMode: switched,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'name is required';
                          }

                          return null;
                        },
                        maxLength: 10,
                        controller: nameControlleer,
                        style: const TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20,
                            color: lightText),
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: ' Name',
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
                    const Text(
                      'Enter Tp Number',
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ///
                    Form(
                      key: _tpnoformKey,
                      autovalidateMode: switched,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          }
                          if (value.length != 10) {
                            return 'Phone number must have 10 digits';
                          }
                          if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Invalid phone number';
                          }
                          return null;
                          return null;
                        },
                        maxLength: 10,
                        controller: tpnoControlleer,
                        style: const TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20,
                            color: lightText),
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: ' Tp Number',
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
                    const Text(
                      'Enter Street',
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _strretformKey,
                      autovalidateMode: switched,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Street is required';
                          }

                          return null;
                        },
                        maxLength: 10,
                        controller: strrtControlleer,
                        style: const TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20,
                            color: lightText),
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: 'Strret',
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
                    const Text(
                      'Enter City',
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _cityformKey,
                      autovalidateMode: switched,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'City is required';
                          }

                          return null;
                        },
                        maxLength: 20,
                        controller: cityControlleer,
                        style: const TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20,
                            color: lightText),
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: 'City',
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
                    const Text(
                      'Enter Password',
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _passwordformKey,
                      autovalidateMode: switched,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password required';
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
                          hintText: 'Password',
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
                    const Text(
                      'Enter  Re  Password',
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _repasswordformKey,
                      autovalidateMode: switched,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Re Password required';
                          }

                          return null;
                        },
                        maxLength: 10,
                        controller: repasswordControlleer,
                        style: const TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20,
                            color: lightText),
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: 'Re Password',
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
                    SizedBox(
                      height: 30,
                    ),
                    RoundedButton(
                        buttonText: 'Register',
                        onPress: () {
                          setState(() {
                            switched = AutovalidateMode.always;
                          });

                          if (_cityformKey.currentState!.validate() &&
                              _nameformKey.currentState!.validate() &&
                              _nicformKey.currentState!.validate() &&
                              _passwordformKey.currentState!.validate() &&
                              _repasswordformKey.currentState!.validate() &&
                              _passwordformKey.currentState!.validate() &&
                              _strretformKey.currentState!.validate()) {
                            if (passwordControlleer.text ==
                                repasswordControlleer.text) {
                              apicontroller.addVolume(
                                  nicNumberControlleer.text
                                      .replaceAll(RegExp(r'[^\d]'), ''),
                                  "10");
                              apicontroller.register(
                                  nicNumberControlleer.text,
                                  nameControlleer.text,
                                  passwordControlleer.text,
                                  context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => LoginScreen(),
                              //     ));
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Center(
                                        child: Text("Password Not Match")),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        }),
                    SizedBox(
                      height: 30,
                    ),
                  ]),
            ),
          ]),
        ));
  }
}
