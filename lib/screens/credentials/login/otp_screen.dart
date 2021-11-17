import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:resipros/database/database_services.dart';
import 'package:resipros/screens/profile_screen.dart';

class OtpScreen extends StatefulWidget {
  String verificationId;
  String phoneNumber;
  OtpScreen(this.verificationId, this.phoneNumber);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  Future signInWithPhone(String phoneNumber) async {
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("Sign in With Phone => Credentials => $credential");
          await auth.signInWithCredential(credential);
          setState(() {
            isLoading = false;
          });
          Get.to(ProfileScreen());
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
            widget.verificationId = verificationId;
            isLoading = false;
          });
          print(
              "Sign in With Phone => codeSent => $verificationId <= Verification ID + Resend Token =>$resendToken");
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
        });
  }

  bool isLoading = false;

  DatabaseServices databaseServices = DatabaseServices();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Color(0xff00adb5)),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  Future verifyOTP() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId, smsCode: controller.text);

      final User? user = (await auth.signInWithCredential(credential)).user;
      setState(() {
        isLoading = false;
      });
      print("verifyOTP Method Called SuccessFully ===> $user");
      Get.to(ProfileScreen());
    } on Exception catch (e) {
      setState(() {
        isLoading = false;
      });
      Get.snackbar('Try agian', 'Some Technical Issue');
      print("verifyOTP Method Called Some Error ===> $e");
    }
  }

  TextEditingController controller = TextEditingController();

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
                  "Enter the valid verification code sent to your mobile",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Karla",
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 75,
              ),
              Container(
                margin: const EdgeInsets.all(20.0),
                padding:
                    const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: PinPut(
                  autofocus: true,
                  fieldsCount: 6,
                  controller: controller,
                  onSubmit: (String pin) {
                    print("$pin OTPSCREEN");
                  },
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
              ArgonTimerButton(
                initialTimer: 30, // Optional
                height: 50,
                width: MediaQuery.of(context).size.width * 0.45,
                minWidth: MediaQuery.of(context).size.width * 0.30,
                color: Color(0xFF7866FE),
                borderRadius: 5.0,
                child: Text(
                  "Resend OTP",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                loader: (timeLeft) {
                  return Text(
                    "Wait | $timeLeft",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  );
                },
                onTap: (startTimer, btnState) {
                  if (btnState == ButtonState.Idle) {
                    signInWithPhone(("+91${widget.phoneNumber}"));
                    startTimer(30);
                  }
                },
              ),
              Flexible(
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
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        verifyOTP();
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 32,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          title: const Text(
            "One Time Password",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Karla",
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
