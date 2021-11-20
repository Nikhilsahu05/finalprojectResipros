import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';

import '../pincode_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String profilePictureURL = "";

  final _picker = ImagePicker();

  XFile? image;
  final storage = FirebaseStorage.instance;
  bool isImageUploading = false;
  uploadImage() async {
    setState(() {
      isImageUploading = true;
    });
    image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    var file = File(image!.path);

    if (image != null) {
      var snapshot = await storage
          .ref("Profile_Picture")
          .child(firebaseAuth.currentUser!.uid)
          .putFile(file)
          .whenComplete(() {
        print("Successfully uploaded image to firebaseStorage");
      }).catchError((onError) {
        print("Image Upload Error ===>$onError");
      });
      var downloadURL = await snapshot.ref.getDownloadURL();

      setState(() {
        profilePictureURL = downloadURL;
        isImageUploading = false;
      });
    } else {
      Get.snackbar("Error", "Try Again and upload image");
    }
  }

  TextEditingController _fullNameTextController = TextEditingController();
  TextEditingController _emailAddrTextController = TextEditingController();
  TextEditingController _genderTextController = TextEditingController();
  String? mobileNumber = "";
  bool isUploading = false;
  bool isLoading = false;

  bool isPincodeSubmitted = false;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future createProfileInformation() async {
    await firebaseFirestore
        .collection("Profile_Information")
        .doc("${firebaseAuth.currentUser!.uid}")
        .set({
      "Full_Name": _fullNameTextController.text,
      "Mobile_Number": mobileNumber,
      "Email_Address": _emailAddrTextController.text,
      "Gender": _genderTextController.text,
      "ProfilePictureURL": profilePictureURL,
    }).then((value) {
      print("ProfileScreen DATABASE SAVED");
    }).catchError((onError) {
      print("ProfileScreen DATABASE Error ===$onError");
    });
  }

  @override
  void initState() {
    mobileNumber = firebaseAuth.currentUser!.phoneNumber;
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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          uploadImage();
                        },
                        child: isImageUploading == true
                            ? CircularProgressIndicator()
                            : CircleAvatar(
                                backgroundImage: profilePictureURL.isEmpty
                                    ? null
                                    : NetworkImage(profilePictureURL),
                                child: profilePictureURL.isEmpty
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Icon(
                                          Icons.person_add_alt_1,
                                          color: Colors.white,
                                          size: 55,
                                        ),
                                      )
                                    : null,
                                backgroundColor: Color(0xff4d61a8),
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
                        decoration: BoxDecoration(
                            color: Color(0xFFEBEBEB),
                            border: Border.all(color: Colors.white)),
                        height: 45,
                        child: TextField(
                          controller: _fullNameTextController,
                          onSubmitted: (value) {},
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
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("$mobileNumber"),
                            )),
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
                          controller: _emailAddrTextController,
                          onSubmitted: (value) {},
                          decoration: InputDecoration(
                              fillColor: Colors.red,
                              hintMaxLines: 3,
                              labelText: 'Email Address',
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
                          controller: _genderTextController,
                          onSubmitted: (value) {},
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
                            onPressed: () async {
                              if (profilePictureURL.isEmpty) {
                                Get.snackbar("Upload Profile", "");
                                return;
                              }
                              if (_fullNameTextController.text.isEmpty) {
                                Get.snackbar("Full name not filled",
                                    "Full Name field is mandatory");
                                return;
                              }

                              if (_genderTextController.text.isEmpty) {
                                Get.snackbar("Gender not filled",
                                    "Gender field is mandatory");
                                return;
                              }

                              await createProfileInformation();
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
