import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pin_put/pin_put.dart';
import 'package:resipros/full_address_screen.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({Key? key}) : super(key: key);

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  bool isLoading = false;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Color(0xff00adb5)),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  String pincode = "";
  TextEditingController pincodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.),

          fontFamily: "Karla"),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 32,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "What is your Pin Code ?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Karla",
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
              ),
              Container(
                margin: const EdgeInsets.all(20.0),
                padding:
                    const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: PinPut(
                  autofocus: true,
                  fieldsCount: 6,
                  controller: pincodeController,
                  submittedFieldDecoration: _pinPutDecoration.copyWith(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  selectedFieldDecoration: _pinPutDecoration,
                  followingFieldDecoration: _pinPutDecoration.copyWith(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Color(0xff292929),
                    ),
                  ),
                ),
              ),
              isLoading == true
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SpinKitFadingCube(
                        size: 45,
                        color: Colors.green,
                      ),
                    )
                  : Flexible(
                      flex: 8,
                      child: Container(
                        height: 300,
                      ),
                    ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xFF4D61A8)),
                      onPressed: () async {
                        setState(() {
                          pincode = pincodeController.text;
                          isLoading = true;
                        });
                        if (pincodeController.text.isEmpty ||
                            pincodeController.text.length != 6) {
                          Get.snackbar("Try Again",
                              ("Pin Code is not 6 digit or is empty"));
                        } else {
                          var response = await http.get(Uri.parse(
                              "https://api.postalpincode.in/pincode/$pincode"));
                          if (response.statusCode == 200) {
                            if (jsonDecode(response.body)[0]["Status"] !=
                                "Success") {
                              Get.snackbar("Try again",
                                  "Pincode does not match with our database");
                            } else {
                              print("Pincode is correct");
                              Get.to(FullAddressScreen(pincode));
                            }
                          } else {
                            Get.snackbar("Some Technical Error",
                                "Try again after some time");
                          }
                        }

                        print(pincode);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Confirm",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
