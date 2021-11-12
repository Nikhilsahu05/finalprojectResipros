import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:resipros/screens/profile_screen.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String refferalCode = " ";

  bool _showCircularProgression = false;

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
                              onPressed: () {
                                Get.to(ProfileScreen());
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
