import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:resipros/database/database_services.dart';
import 'package:resipros/screens/credentials/login/otp_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  DatabaseServices databaseServices = DatabaseServices();

  bool isLoading = false;

  TextEditingController _phoneNumberController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future signInWithPhone(String phoneNumber) async {
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("Sign in With Phone => Credentials => $credential");
          await auth.signInWithCredential(credential);
          setState(() {
            isLoading = false;
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            isLoading = false;
          });
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
            Get.snackbar("Try Again", "Phone number is not valid.");
          }
          print("Sign in With Phone => VerificationFailed => $e");
          print(
              "Some Exceptions Occur While Sending otp ==> ${e.code} +++ ${e.message}");

          Get.snackbar("Try Again", "${e.code}");
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            isLoading = false;
          });
          print(
              "Sign in With Phone => codeSent => $verificationId <= Verification ID + Resend Token =>$resendToken");

          databaseServices.sendWhatsAppNotification(
              whatsappNotifications, _phoneNumberController.text);
          Get.to(OtpScreen(verificationId, _phoneNumberController.text));
        },
        timeout: const Duration(seconds: 30),
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            isLoading = false;
          });
          print(
              "Sign in With Phone => codeAutoRetrievalTimeout => $verificationId <= Verification ID");
          print(
              "Sign in With Phone => codeAutoRetrievalTimeout => ****TIMEOUT****  ");

          Get.snackbar("Try Again", "OTP Entering Timeout");
        });
  }

  bool whatsappNotifications = true;

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
        backgroundColor: Color(0xFFFFFFFF),
        body: Container(
          padding: EdgeInsets.all(12.0),
          child: isLoading == true
              ? SpinKitDoubleBounce(
                  size: 150,
                  color: Colors.blue,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 75,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 40.0, right: 40, top: 20),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 3),
                          child: TextField(
                            controller: _phoneNumberController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            style: const TextStyle(
                                color: Colors.black, letterSpacing: 3),
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
                      flex: 8,
                      child: Container(
                        height: 300,
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Color(0xff00adb5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          value: whatsappNotifications,
                          onChanged: (newValue) {
                            setState(() {
                              whatsappNotifications = newValue!;
                            });
                          },
                        ),
                        Text(
                            "I agree to receive offers and updates via Whatsapp",
                            style:
                                TextStyle(fontSize: 12, color: Colors.black)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFF4D61A8)),
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                              });
                              signInWithPhone(
                                  "+91${_phoneNumberController.text}");
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
                  ],
                ),
        ),
      ),
    );
  }
}
