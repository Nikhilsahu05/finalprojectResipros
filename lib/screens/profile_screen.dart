import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:resipros/pincode_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String district = " District";
  String state = " State ";
  List localities = [];

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String phoneNumber = "";
  bool isUploading = false;
  File? image;
  var profileImage = "";

  TextEditingController _fullNameTextController = TextEditingController();
  TextEditingController _fullAddressController = TextEditingController();
  TextEditingController _pinCodeTextController = TextEditingController();

  var numberOfPostalCodes;
  bool isLoading = false;

  String? _selected;
  bool isPincodeSubmitted = false;
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
        backgroundColor: Colors.white,
        body: isLoading
            ? Padding(
                padding: const EdgeInsets.all(100.0),
                child: Center(
                    child: SpinKitFadingCube(
                  color: Colors.blueAccent,
                  size: 100.0,
                )),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 40.0, right: 40, top: 20),
                    child: const Text(
                      "Personal Information",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Karla",
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: isUploading
                            ? CircularProgressIndicator()
                            : CircleAvatar(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Icon(
                                    Icons.person_add_alt_1,
                                    color: Colors.white,
                                    size: 70,
                                  ),
                                ),
                                backgroundColor: Color(0xff4d61a8),
                                maxRadius: 60,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 7),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFEBEBEB),
                            border: Border.all(color: Colors.white)),
                        height: 45,
                        child: TextField(
                          controller: _fullNameTextController,
                          onSubmitted: (value) {
                            _fullNameTextController.text = value;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.red,
                              hintMaxLines: 3,
                              labelText: 'Full Name',
                              labelStyle:
                                  TextStyle(fontSize: 13, color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.5, color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Color(0xff00adb5)),
                              )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 7),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFEBEBEB),
                            border: Border.all(color: Colors.white)),
                        height: 45,
                        child: Center(child: Text("+91 7879232321")),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 7),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFEBEBEB),
                            border: Border.all(color: Colors.white)),
                        height: 45,
                        child: TextField(
                          controller: _fullNameTextController,
                          onSubmitted: (value) {
                            _fullNameTextController.text = value;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.red,
                              hintMaxLines: 3,
                              labelText: 'Email Address',
                              suffix: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "(Optional)",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              labelStyle:
                                  TextStyle(fontSize: 13, color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.5, color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Color(0xff00adb5)),
                              )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 7),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFEBEBEB),
                            border: Border.all(color: Colors.white)),
                        height: 45,
                        child: TextField(
                          controller: _fullNameTextController,
                          onSubmitted: (value) {
                            _fullNameTextController.text = value;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.red,
                              hintMaxLines: 3,
                              labelText: 'Gender',
                              labelStyle:
                                  TextStyle(fontSize: 13, color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.5, color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Color(0xff00adb5)),
                              )),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Container(
                      height: 250,
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 18),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFF4D61A8)),
                            onPressed: () {
                              Get.to(PinCodeScreen());
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
                  )
                ],
              ),
      ),
    );
  }
}
