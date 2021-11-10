import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:resipros/screens/database_services.dart';
import 'package:resipros/screens/profile_screen.dart';

import '../../home_screen.dart';

class OtpScreen extends StatefulWidget {
  var verificationId;

  OtpScreen(this.verificationId);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String refferalCode = " ";

  bool _showCircularProgression = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    DataBaseServices _databaseServices = DataBaseServices();

    final authCredential =
        await _auth.signInWithCredential(phoneAuthCredential);

    try {
      if (authCredential.user != null) {
        if (authCredential.additionalUserInfo!.isNewUser) {
          setState(() {
            refferalCode = _auth.currentUser!.uid.removeAllWhitespace
                .substring(0, 6)
                .toUpperCase();
            Get.snackbar("New User", "First Time Registered",
                overlayColor: Colors.grey, colorText: Colors.black);
          });

          _databaseServices.storeRefferalCode(refferalCode);
          _databaseServices
              .storePhoneNumberInformation(_auth.currentUser?.phoneNumber);
          Get.to(ProfileScreen());
        } else {
          print(
              "signInWithPhoneAuthCredential + ${authCredential.additionalUserInfo!.isNewUser} is a not a new user");
          setState(() {
            _showCircularProgression = false;
            Get.snackbar("Returning User", "Regular Customer",
                overlayColor: Colors.grey, colorText: Colors.black);
          });

          Get.to(HomeScreen());
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Verify OTP Error", "$e",
          overlayColor: Colors.grey, colorText: Colors.black);
      setState(() {
        _showCircularProgression = false;
        Get.snackbar("try again", "",
            overlayColor: Colors.grey, colorText: Colors.black);
      });
    }

    setState(() {
      _showCircularProgression = false;
    });
  }

  TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.only(left: 40.0, right: 40, top: 20),
              child: const Text(
                "Enter the valid verification code",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 75,
            ),
            OtpTextField(
              numberOfFields: 6,

              borderWidth: 3,
              autoFocus: true,
              focusedBorderColor: Color(0xffB983FF),
              textStyle: const TextStyle(
                color: Colors.black,
              ),
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) {
                _otpController.text = verificationCode;
              }, // end onSubmit
            ),
            const SizedBox(
              height: 75,
            ),
            _showCircularProgression
                ? CircularProgressIndicator()
                : Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Container(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xffB983FF)),
                              onPressed: () async {
                                setState(() {
                                  _showCircularProgression = true;
                                });
                                PhoneAuthCredential phoneAuthCredential =
                                    PhoneAuthProvider.credential(
                                        verificationId: widget.verificationId,
                                        smsCode: _otpController.text);
                                signInWithPhoneAuthCredential(
                                    phoneAuthCredential);
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Confirm",
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        color: Colors.black),
                                  ),
                                ],
                              ))),
                    ),
                  ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: const Text(
          "OTP",
          style: TextStyle(
            fontFamily: "Roboto",
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
    );
  }
}
