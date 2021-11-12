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
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFFFFF),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 75,
            ),
            Container(
              padding: const EdgeInsets.only(left: 40.0, right: 40, top: 20),
              child: const Text(
                "What's your phone number?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Karla",
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: const Text(
                "This is first step to use Resipros",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Karla",
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              padding: const EdgeInsets.only(left: 25.0, right: 12.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  color: Color(0xFFebebeb),
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
                        padding: EdgeInsets.only(
                          right: 15,
                        ),
                        child: Text(
                          "+91",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 18.0),
                        child: Icon(
                          Icons.phone,
                          color: Colors.green,
                        ),
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
            Flexible(
              flex: 6,
              child: Container(
                height: 300,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  value: true,
                  onChanged: (onChanged) {},
                  activeColor: Color(0xff00adb5),
                ),
                Text(
                  "I agree to receive offers and updates via Whatsapp",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontFamily: "Karla"),
                ),
              ],
            ),
            _showCircularIndication
                ? CircularProgressIndicator()
                : Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFF4D61A8)),
                            onPressed: () {
                              Get.to(OtpScreen());
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
                  ),
          ],
        ),
      ),
    );
  }
}
