import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:resipros/screens/credentials/registration/otp_screen.dart';

import 'otp_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _phoneNumberController = TextEditingController();

  bool _showCircularIndication = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "LOGIN",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 40.0, right: 40, top: 20),
              child: const Text(
                "What's your phone number?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: const Text(
                "It\'s first step to use Resipros",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(left: 25.0, right: 12.0, top: 35),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 3),
                  child: TextField(
                    controller: _phoneNumberController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    style:
                        const TextStyle(color: Colors.black, letterSpacing: 3),
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefix: Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Text(
                          "+91",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      border: InputBorder.none,
                      hintText: 'XXXXX-XXXXX',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF7A7A7A),
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            _showCircularIndication
                ? CircularProgressIndicator()
                : Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Color(0xffB983FF),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFB983FF)),
                          onPressed: () {
                            Get.to(OtpScreen());
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Confirm",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          )),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
