import 'package:qr_generator_tutorial/Controller/constant.dart';
import 'package:qr_generator_tutorial/pages/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../pages/Main_Screen.dart';

class Apicontroller {
  register(nic, name, String password, BuildContext context) async {
    Map data = {
      'username': nic,
      'name': name,
      'email': password,
    };

    // ignore: avoid_print
    print("post data $data");

    String body = json.encode(data);
    // ignore: prefer_interpolation_to_compose_strings
    var url = Uri.parse("http://" + constant.BASE_URL.trim() + "/user");
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
      },
    );
    // ignore: avoid_print
    print(response.body);
    print(response.statusCode);
    var jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Logger().i('success customer login');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    } else {
      Logger().e('error');

      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Unsucesfull Login")),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  login(String nicnumber, password, BuildContext context) async {
    try {
      final details = await SharedPreferences.getInstance();
      Map data = {
        'username': nicnumber,
        'email': password,
      };

      // ignore: avoid_print
      print("post data $data");

      String body = json.encode(data);

      var url = Uri.parse("http://" + constant.BASE_URL.trim() + "/login");
      var response = await http.post(
        url,
        body: body,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
        },
      );
      // ignore: avoid_print
      print(response.body);
      print(response.statusCode);

      var responseData = json.decode(response.body);
      String id, name, nic;
      bool login;

      if (response.statusCode == 200) {
        login = true;
        id = responseData['id'].toString();
        nic = responseData['username'].toString();
        name = responseData['name'].toString();

        //Or put here your next screen using Navigator.push() method
        // Obtain shared preferences.

        await details.setString('userId', id);
        await details.setString('nic', nic);
        await details.setString('userName', name);
        await details.setBool('islog', true);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false);

        Logger().i('success custom login');
      } else {
        Logger().e('error');
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(child: Text(response.body.toString().trimLeft())),
              actions: <Widget>[
                Center(
                  child: ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle the exception here
      Logger().e('Exception: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: const Text('Password Wrong!')),
            content: Text('                     Try Again'),
            actions: <Widget>[
              Center(
                child: ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        },
      );
    }
  }

  //get customer details  (my profile read only)
  getuserdetailss(String id) async {
    final customerdetails = await SharedPreferences.getInstance();

    // replace your restFull API here
    var url = Uri.parse("http://" + constant.BASE_URL.trim() + "/user/$id");
    final response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);

    var responseData = json.decode(response.body);
    print(response.body);
    print(response.statusCode);
    String nic, pw, name;

    nic = jsonResponse['username'].toString();
    pw = jsonResponse['email'].toString();
    name = jsonResponse['name'].toString();

    await customerdetails.setString('username', name);
    await customerdetails.setString('pw', pw);
    await customerdetails.setString('nic', nic);

    print(pw.toString());

    // Creating a list to store input data;
  }

  Future<void> addVolume(String id, String volumeName) async {
    Map<String, dynamic> data = {
      'id': id,
      'volume': volumeName,
    };

    print("post data $data");

    String body = json.encode(data);
    var url = Uri.parse("http://" + constant.BASE_URL.trim() + "/api/volumes");
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
      },
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      String volume = jsonResponse['volume'].toString();
      Logger().i('Volume added successfully: $volume');
    } else {
      Logger().e('Error adding volume: ${response.statusCode}');
    }
  }

  getvolume(String id) async {
    final customerdetails = await SharedPreferences.getInstance();

    // replace your restFull API here
    var url =
        Uri.parse("http://" + constant.BASE_URL.trim() + "/api/volumes/$id");
    final response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);

    var responseData = json.decode(response.body);
    print(response.body);
    print(response.statusCode);
    String volume, pw, name;

    volume = jsonResponse['volume'].toString();

    await customerdetails.setString('volume', volume);

    // Creating a list to store input data;
  }
}
