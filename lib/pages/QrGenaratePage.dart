import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_generator_tutorial/Controller/api/api_controller.dart';
import 'package:qr_generator_tutorial/pages/rounded_button.dart';
import 'package:qr_generator_tutorial/ui/Colors.dart';
import 'package:qr_generator_tutorial/ui/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrGenaratePage extends StatefulWidget {
  const QrGenaratePage({Key? key}) : super(key: key);

  @override
  State<QrGenaratePage> createState() => _QrGenaratePageState();
}

class _QrGenaratePageState extends State<QrGenaratePage> {
  String volume = "";
  String nic = "";
  String userid = "";
  String data = "";
  String data1 = "";
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
    final customerdetails = await SharedPreferences.getInstance();
    final details = await SharedPreferences.getInstance();

  
    apicontroller.getvolume(nic.toString().replaceAll(RegExp(r'[^\d]'), ''));
    setState(() {
      volume = customerdetails.getString('volume').toString()+'L';
        nic = details.getString('nic').toString();
      data = volume +' '+nic.toString() ;
      data1 = volume ;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(
                child: QrImage(
                  data: data,
                  backgroundColor: Colors.white,
                  version: QrVersions.auto,
                  size: 300.0,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: Container(
                  height: 150,
                  width: 300,
                  color: Kyellow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Avalable Water Balance :',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          color: AppStyle.primaryColor,
                          height: 50,
                          width: 200,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.water,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Text(data1 ,
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 30.0,
                                      color: white,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: RoundedButton(
                    buttonText: "Refesh",
                    onPress: () {
                      apicontroller.getvolume(
                          nic.toString().replaceAll(RegExp(r'[^\d]'), ''));
                      getuserdata();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
