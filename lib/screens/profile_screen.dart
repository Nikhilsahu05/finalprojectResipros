import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:resipros/screens/database_services.dart';
import 'package:resipros/screens/work_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String district = " District";
  String state = " State ";
  List localities = [];

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String phoneNumber = "";
  bool isUploading = false;
  File? image;
  var profileImage = "";
  FirebaseAuth _Auth = FirebaseAuth.instance;

  TextEditingController _fullNameTextController = TextEditingController();
  TextEditingController _fullAddressController = TextEditingController();
  TextEditingController _pinCodeTextController = TextEditingController();

  var numberOfPostalCodes;
  bool isLoading = false;
  Future<dynamic> getLocationByPostalCode() async {
    isLoading = true;
    final response = await http.get(Uri.parse(
        'https://api.postalpincode.in/pincode/${_pinCodeTextController.text}'));

    try {
      if (response.statusCode == 200) {
        final bodyData = json.decode(response.body);
        if (bodyData[0]["Status"] == 'Error') {
          setState(() {
            isLoading = false;
          });
          print('PINCODE NOT FOUND');
          Get.snackbar("Try Again", "PIN CODE NOT FOUND");
        } else {
          final length = bodyData[0]["PostOffice"].length;
          setState(() {
            numberOfPostalCodes = length;
          });
          print("Number of jsonDEcode =====> $length");
          var responseJson = response.body;
          String jsonsDataString = responseJson.toString();
          final jsonData = jsonDecode(jsonsDataString);

          print(jsonData[0]["PostOffice"][0]["District"]);

          print("$state ===> State");
          print("$district ===> District");
          print("${localities.toString()} ===> Localites");
          print("$numberOfPostalCodes ===> number of postal codes");

          setState(() {
            district = jsonData[0]["PostOffice"][0]["District"];
            state = jsonData[0]["PostOffice"][0]["State"];
            for (var i = 0; i <= numberOfPostalCodes - 1; i++) {
              localities.add(bodyData[0]["PostOffice"][i]["Name"]);
              print(localities);
            }
            print("$localities ==> final locality list");
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception("Failed to load");
      }
    } on Exception catch (e) {
      print('Exception catched on retriving api key =====> $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  DataBaseServices _dataBaseServices = DataBaseServices();

  Future getImage(ImageSource source) async {
    var image = await ImagePicker().pickImage(source: source);
    if (image!.path.length != 0) {
      File imagePath = File(image.path);
      print("process stated");
      setState(() {
        isUploading = true;
        if (isUploading == true) {}
      });
      FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

      _firebaseStorage
          .ref()
          .child("profileImage")
          .child("${_Auth.currentUser!.uid}")
          .putFile(imagePath)
          .then((res) {
        print("GET IMAGE SUCCESS THEN ==> $res");
        res.ref.getDownloadURL().then((url) {
          print(
              "GET IMAGE SUCCESSFULLY RETRIEVED URL OF IMAGE FROM FIRESTORE + $url");
          setState(() {
            profileImage = url;
            setState(() {
              isUploading = false;
            });
            print("process ended");
          });
        }).catchError((error) {
          print("GET IMAGE ERROR ON DOWNLOADING URL + $error");
        });
      }).catchError((e) {
        print("getImage Error + $e");
      });
    } else {
      print('No File Picked');
    }
  }

  String? _selected;

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
                        onTap: () {
                          getImage(ImageSource.camera);
                        },
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
                            "${_firebaseAuth.currentUser?.phoneNumber}",
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
                        height: 45,
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
                                child: TextField(
                                  controller: _pinCodeTextController,
                                  onSubmitted: (value) {
                                    print(localities);
                                    print("Submited");
                                    setState(() {
                                      _pinCodeTextController.text = value;
                                      getLocationByPostalCode();
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      suffix: InkWell(
                                          onTap: () {
                                            print(localities);
                                            print("Submited");
                                            setState(() {
                                              getLocationByPostalCode();
                                            });
                                          },
                                          child: Text("Check")),
                                      suffixStyle: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline),
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
                                    "India",
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
                  Padding(
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
                  Padding(
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
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Text(map)),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_fullNameTextController.text.isEmpty) {
                            return Get.snackbar("Please Enter Valid Details",
                                "Name Should be Valid");
                          }
                          if (_fullAddressController.text.isEmpty) {
                            return Get.snackbar("Please Enter Valid Details",
                                "Address Should be Valid");
                          }
                          if (_pinCodeTextController.text.isEmpty) {
                            return Get.snackbar("Please Enter Valid Details",
                                "PinCode Should be Valid");
                          }
                          _dataBaseServices.storeProfileInformation(
                            profileImage,
                            _fullNameTextController,
                            _fullAddressController,
                            _pinCodeTextController,
                            _selected,
                            state,
                            district,
                          );

                          Get.offAll(WorkProfileScreen());
                        },
                        child: Text(
                          "Proceed",
                          style: TextStyle(fontSize: 24),
                        )),
                  )
                ],
              ),
      ),
    );
  }
}
