import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:resipros/screens/work_profile_screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          "Profile Information",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: isLoading
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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: isUploading
                            ? CircularProgressIndicator()
                            : CircleAvatar(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Icon(
                                    Icons.person_add_alt_1,
                                    color: Colors.black,
                                    size: 90,
                                  ),
                                ),
                                backgroundColor: Color(0xFFB983FF),
                                maxRadius: 60,
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 7),
                    child: Center(
                      child: Container(
                        height: 45,
                        child: TextField(
                          controller: _fullNameTextController,
                          onSubmitted: (value) {
                            _fullNameTextController.text = value;
                          },
                          decoration: InputDecoration(
                              hintMaxLines: 3,
                              labelText: 'Full Name',
                              labelStyle: TextStyle(fontSize: 13),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.5, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.5, color: Colors.blue),
                                borderRadius: BorderRadius.circular(10.0),
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
                        foregroundDecoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 7),
                    child: Center(
                      child: Container(
                        height: 70,
                        child: TextField(
                          maxLength: 30,
                          controller: _fullAddressController,
                          onSubmitted: (value) {
                            _fullAddressController.text = value;
                          },
                          decoration: InputDecoration(
                              labelText: 'Full Address',
                              labelStyle: TextStyle(fontSize: 13),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.2, color: Colors.blue),
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.0),
                    child: Row(
                      children: [
                        FadeIn(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          child: Visibility(
                            visible: isPincodeSubmitted == false ? true : false,
                            child: SizedBox(
                              width: 100,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              left: 30,
                            ),
                            child: Center(
                              child: Container(
                                height: 45,

                                width:158,
                                child: TextField(
                                  controller: _pinCodeTextController,
                                  onSubmitted: (value) {},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      suffix: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isPincodeSubmitted = true;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("OK"),
                                        ),
                                      ),
                                      hintMaxLines: 3,
                                      labelText: 'Pin Code',
                                      labelStyle: TextStyle(fontSize: 13),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.5, color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.5, color: Colors.blue),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isPincodeSubmitted == false ? false : true,
                          child: FadeIn(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            child: Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 30,
                                  left: 10,
                                ),
                                child: Center(
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    height: 45,
                                    width:158,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        "India",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isPincodeSubmitted == false ? true : false,
                          child: FadeIn(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            child: SizedBox(
                              width: 100,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isPincodeSubmitted == true ? true : false,
                    child: FadeIn(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 10.0,
                                  left: 30,
                                ),
                                child: Center(
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    height: 45,
                                    width: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        "$district",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 30,
                                  left: 10,
                                ),
                                child: Center(
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    height: 45,
                                    width: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        "$state",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isPincodeSubmitted == true ? true : false,
                    child: FadeIn(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 7),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.grey)),
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  dropdownColor: Color(0xeeffffff),
                                  isDense: true,
                                  hint: const Text("Select Locality"),
                                  value: _selected,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selected = newValue;

                                      Get.snackbar("$_selected Selected",
                                          "Your Locality is $_selected");
                                      print(_selected);
                                    });
                                  },
                                  items: localities.map((map) {
                                    return DropdownMenuItem<String>(
                                      value: map.toString(),
                                      // value: _mySelection,
                                      child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(map)),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Visibility(
                    visible: isPincodeSubmitted == true ? true : false,
                    child: Center(
                      child: ElevatedButton(
                          onPressed: () {
                            Get.offAll(WorkProfileScreen());
                          },
                          child: Text(
                            "Proceed",
                            style: TextStyle(fontSize: 24),
                          )),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
