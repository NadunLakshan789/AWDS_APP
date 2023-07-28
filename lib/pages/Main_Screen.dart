import 'package:flutter/material.dart';
import 'package:qr_generator_tutorial/Controller/api/api_controller.dart';

import 'package:qr_generator_tutorial/pages/QrGenaratePage.dart';
import 'package:qr_generator_tutorial/pages/Recharge_Screen.dart';
import 'package:qr_generator_tutorial/pages/SplashScreen.dart';
import 'package:qr_generator_tutorial/pages/login_screen.dart';
import 'package:qr_generator_tutorial/ui/Colors.dart';
import 'package:qr_generator_tutorial/ui/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen();

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  List<Widget> list = [const QrGenaratePage(), const RechargeScreen()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyle.primaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Kyellow,
          foregroundColor: darkText,
          title: index == 0
              ? Text(
                  "AWDS",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                )
              : Text(""),
          centerTitle: true,
        ),
        body: list[index],
        drawer: MyDrawer(onTap: (lol, i) {
          setState(() {
            index = i;
            Navigator.pop(lol);
          });
        }),
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  final Function onTap;

  const MyDrawer({required this.onTap});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String name = "";
  String userid = "";
  Apicontroller apicontroller = Apicontroller();
  getuserdata() async {
    final details = await SharedPreferences.getInstance();
    setState(() {
      userid = details.getString('userId').toString();
    });
    print("my user id is : " + userid.toString());
    apicontroller.getuserdetailss(userid.toString());
    getcustomerdata();
  }

  getcustomerdata() async {
    apicontroller.getuserdetailss(userid.toString());
    final details = await SharedPreferences.getInstance();

    setState(() {
      name = details.getString('username').toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    getuserdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: AppStyle.primaryColor,
        child: Container(
          color: AppStyle.primaryColor,
          margin: EdgeInsets.only(left: 35, top: 20),
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    "Hey",
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 20,
                      color: darkText,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    name.toString(),
                    style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 25,
                        color: darkText,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(
                height: 45,
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Kyellow),
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 5,
                title: const Text(
                  "Home",
                  style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 22,
                      color: darkText,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () => widget.onTap(context, 0),
              ),
              ListTile(
                leading:
                    const Icon(Icons.battery_2_bar_outlined, color: Kyellow),
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 5,
                title: const Text(
                  "Recharge",
                  style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 22,
                      color: darkText,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () => widget.onTap(context, 1),
              ),
              InkWell(
                child: ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Kyellow),
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 5,
                  title: const Text(
                    "Exit",
                    style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 22,
                        color: darkText,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                onTap: () async {
                  final details = await SharedPreferences.getInstance();
                  details.clear();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
