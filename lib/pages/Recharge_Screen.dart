import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:qr_generator_tutorial/Controller/api/api_controller.dart';
import 'package:qr_generator_tutorial/pages/Main_Screen.dart';
import 'package:qr_generator_tutorial/pages/QrGenaratePage.dart';
import 'package:qr_generator_tutorial/pages/rounded_button.dart';
import 'package:qr_generator_tutorial/ui/Colors.dart';
import 'package:qr_generator_tutorial/ui/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({Key? key}) : super(key: key);

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  String volumes = "";
  String nic = "";
  String userid = "";
  String data = "";
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

    nic = details.getString('nic').toString();
    apicontroller.getvolume(nic.toString().replaceAll(RegExp(r'[^\d]'), ''));
    setState(() {
      volumes = customerdetails.getString('volume').toString();
    });
  }

  AutovalidateMode switched = AutovalidateMode.disabled;
  final _cardnumberformKey = GlobalKey<FormState>();
  final _cvcformKey = GlobalKey<FormState>();
  final _cardhodernameformKey = GlobalKey<FormState>();
  final _expectiondateformKey = GlobalKey<FormState>();
  final _moneyformKey = GlobalKey<FormState>();
  final nameControlleer = TextEditingController();
  final cardControlleer = TextEditingController();
  final cvcControlleer = TextEditingController();
  final cardholdernameControlleer = TextEditingController();
  final expectiondateControlleer = TextEditingController();
  final moneyControlleer = TextEditingController();
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: const Text('Recharge Your',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            const Text('Water  Balance',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 30.0,
                  color: Kyellow,
                  fontWeight: FontWeight.w700,
                )),
            // SizedBox(
            //   height: 10,
            // ),
            CardSection(
                amountControlleer: moneyControlleer,
                cardholdercontroller: cardholdernameControlleer,
                cardnumberformKey: _cardnumberformKey,
                switched: switched,
                cardControlleer: cardControlleer,
                cvcformKey: _cvcformKey,
                cvcControlleer: cvcControlleer,
                cardhodernameformKey: _cardhodernameformKey,
                expectiondateformKey: _expectiondateformKey,
                expectiondateControlleer: expectiondateControlleer,
                moneyformKey: _moneyformKey),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: RoundedButton(
                  buttonText: "Complete Order",
                  onPress: () {
                    setState(() {
                      switched = AutovalidateMode.always;

                      if (_cardhodernameformKey.currentState!.validate() &&
                          _cvcformKey.currentState!.validate() &&
                          _moneyformKey.currentState!.validate() &&
                          _expectiondateformKey.currentState!.validate() &&
                          _cardhodernameformKey.currentState!.validate()) {
                        double money = double.parse(moneyControlleer.text);
                        double volume = money / 3;

                        String final_volume = "40";
                        int result = 0;

                        setState(() {
                          result = volume.toInt() + int.parse(volumes);
                        });

                        apicontroller.addVolume(
                            nic.toString().replaceAll(RegExp(r'[^\d]'), ''),
                            result.toString());

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ));
                      }
                    });
                  }),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

class CardSection extends StatelessWidget {
  const CardSection(
      {Key? key,
      required GlobalKey<FormState> cardnumberformKey,
      required this.switched,
      required this.cardControlleer,
      required GlobalKey<FormState> cvcformKey,
      required this.cvcControlleer,
      required GlobalKey<FormState> cardhodernameformKey,
      required GlobalKey<FormState> expectiondateformKey,
      required this.expectiondateControlleer,
      required GlobalKey<FormState> moneyformKey,
      required this.amountControlleer,
      required this.cardholdercontroller})
      : _cardnumberformKey = cardnumberformKey,
        _cvcformKey = cvcformKey,
        _cardhodernameformKey = cardhodernameformKey,
        _expectiondateformKey = expectiondateformKey,
        _moneyformKey = moneyformKey,
        super(key: key);

  final GlobalKey<FormState> _cardnumberformKey;
  final AutovalidateMode switched;
  final TextEditingController cardControlleer;
  final TextEditingController cardholdercontroller;
  final TextEditingController amountControlleer;

  final GlobalKey<FormState> _cvcformKey;
  final TextEditingController cvcControlleer;
  final GlobalKey<FormState> _cardhodernameformKey;
  final GlobalKey<FormState> _expectiondateformKey;
  final TextEditingController expectiondateControlleer;
  final GlobalKey<FormState> _moneyformKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Container(
        color: white,
        height: 500,
        width: 400,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    'Card number',
                    style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 150,
                  ),
                  Text(
                    'CVV',
                    style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Flexible(
                    child: Form(
                      key: _cardnumberformKey,
                      autovalidateMode: switched,
                      child: TextFormField(
                        maxLength: 16,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'required';
                          }
                          if (value.length != 16) {
                            return ' 16 digits need';
                          }

                          return null;
                        },
                        controller: cardControlleer,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20,
                            color: lightText),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'enter pin number',
                          fillColor: Kyellow,
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
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Form(
                      key: _cvcformKey,
                      autovalidateMode: switched,
                      child: TextFormField(
                        maxLength: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'cvc required';
                          }
                          if (value.length != 3) {
                            return ' 3 digits need';
                          }

                          return null;
                        },
                        controller: cvcControlleer,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20,
                            color: lightText),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'enter cvc',
                          fillColor: Kyellow,
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    'Card Holder Name',
                    style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 150,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Flexible(
                    child: Form(
                      key: _cardhodernameformKey,
                      autovalidateMode: switched,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'card holder name is required';
                          }

                          return null;
                        },
                        controller: cardholdercontroller,
                        style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20,
                            color: lightText),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'enter name',
                          fillColor: Kyellow,
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    'Experation Date',
                    style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 150,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Flexible(
                    child: Form(
                      key: _expectiondateformKey,
                      autovalidateMode: switched,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'month/yaer required';
                          }

                          return null;
                        },
                        controller: expectiondateControlleer,
                        style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20,
                            color: lightText),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'MM/YY',
                          fillColor: Kyellow,
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 150,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Flexible(
                    child: Form(
                      key: _moneyformKey,
                      autovalidateMode: switched,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Amount is required';
                          }

                          // validate that the input contains only digits
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Please enter a valid number';
                          }

                          return null;
                        },
                        controller: amountControlleer,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 20,
                          color: lightText,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Enter Amount',
                          fillColor: Kyellow,
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
