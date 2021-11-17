import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resipros/screens/home_screen.dart';

class SettingsProfileScreen extends StatefulWidget {
  @override
  _SettingsProfileScreenState createState() => _SettingsProfileScreenState();
}

class _SettingsProfileScreenState extends State<SettingsProfileScreen> {
  String profilePictureURL = "";
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _picker = ImagePicker();

  XFile? image;
  final storage = FirebaseStorage.instance;
  bool isImageUploading = false;

  TextEditingController _genderTextController = TextEditingController();

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
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

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future updateProfileInformation() async {
    await firebaseFirestore
        .collection(firebaseAuth.currentUser!.uid)
        .doc("Profile_Information")
        .update({
      "Email_Address": _emailAddressController.text,
      "Full_Name": _fullNameController.text,
      "Gender": _genderTextController.text,
      "ProfilePictureURL": profilePictureURL,
    }).then((value) {
      print("Settings profile screen database updated");
    }).catchError((onError) {
      print("Some Error Cought On Updating Database $onError");
    });
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
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 32,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              "Edit Profile",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Karla",
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          uploadImage();
                        },
                        child: CircleAvatar(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: profilePictureURL == null
                                ? Icon(
                                    Icons.person_add_alt_1,
                                    color: Colors.white,
                                    size: 55,
                                  )
                                : null,
                          ),
                          backgroundColor: Color(0xff4d61a8),
                          backgroundImage: NetworkImage(profilePictureURL),
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
                          controller: _fullNameController,
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
                              child: Text("$phoneNumberDashboard"),
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
                          controller: _emailAddressController,
                          onSubmitted: (value) {},
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
                  SizedBox(
                    height: 50,
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
                              updateProfileInformation();
                              Navigator.pop(context);
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
                                  "Save Changes",
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
          ),
        ));
  }
}
