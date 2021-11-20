import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:resipros/screens/work_profile_screen.dart';

class FullAddressScreen extends StatefulWidget {
  String pincode;

  FullAddressScreen(this.pincode);

  @override
  _FullAddressScreenState createState() => _FullAddressScreenState();
}

class _FullAddressScreenState extends State<FullAddressScreen> {
  TextEditingController houseNumber = TextEditingController();

  var selectedLocality;

  List localities = [];
  bool isLoading = false;
  String stateProfile = "";
  String districtProfile = "";
  Future getLocation() async {
    setState(() {
      isLoading = true;
    });
    print("${widget.pincode} <==== Recieved Pincode ");
    var response = await http.get(
        Uri.parse("https://api.postalpincode.in/pincode/${widget.pincode}"));
    if (response.statusCode == 200) {
      var district =
          await jsonDecode(response.body)[0]["PostOffice"][1]["District"];

      var state = await jsonDecode(response.body)[0]["PostOffice"][1]["State"];
      var length = jsonDecode(response.body)[0]["PostOffice"];
      int len = length.length;
      for (int i = 0; i <= len - 1; i++) {
        var names = await jsonDecode(response.body)[0]["PostOffice"][i]["Name"];
        localities.add(names);
      }
      print(localities);
      print(len);
      setState(() {
        stateProfile = state;
        districtProfile = district;
      });
      print(stateProfile);
      print(districtProfile);
    } else {
      Get.snackbar('Try again', "Technical Issues , Try After Some Time");
    }
    setState(() {
      isLoading = false;
    });
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future createAddressInformation() async {
    await firebaseFirestore
        .collection("Full_Address")
        .doc("${firebaseAuth.currentUser!.uid}")
        .set({
      "House_Number": houseNumber.text,
      "Locality": selectedLocality,
      "State": stateProfile,
      "District": districtProfile,
      "Pin_Code": widget.pincode,
    }).then((value) {
      print("FullAddressScreen DATABASE SAVED");
    }).catchError((onError) {
      print("FullAddressScreen DATABASE Error ===$onError");
    });
  }

  DropdownButton<String> localitiesDropDown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (var item in localities) {
      String currency = item;
      var newItem = DropdownMenuItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            currency,
            style: TextStyle(fontSize: 13, color: Colors.black),
          ),
        ),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    ;
    return DropdownButton<String>(
        underline: SizedBox(),
        isExpanded: true,
        value: selectedLocality,
        items: dropdownItems,
        onChanged: (var value) {
          setState(() {
            selectedLocality = value!;
            print(selectedLocality);
            print(value);
          });
        });
  }

  @override
  void initState() {
    print(widget.pincode);
    getLocation();
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
            "What's your Address ?",
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
        body: isLoading == true
            ? SpinKitDancingSquare(
                size: 150,
                color: Colors.green,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 87),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Pin Code",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Karla",
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 95,
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Text(
                          "Change",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Text(
                      "${widget.pincode}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Karla",
                        letterSpacing: 25,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
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
                          controller: houseNumber,
                          onSubmitted: (value) {},
                          decoration: InputDecoration(
                              fillColor: Colors.red,
                              hintMaxLines: 3,
                              labelText: 'House Number',
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
                          child: localitiesDropDown()),
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
                                padding: const EdgeInsets.all(8.0),
                                child: Text("$districtProfile"),
                              ))),
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
                                padding: const EdgeInsets.all(8.0),
                                child: Text("$stateProfile"),
                              ))),
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
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Image.asset("assets/indian_flag.png"),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text("India"),
                                    ),
                                  ],
                                ),
                              ))),
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
                              if (houseNumber.text.isEmpty) {
                                Get.snackbar(
                                    "Fill", "House Number is mandatory");
                                return;
                              }
                              if (selectedLocality == null) {
                                Get.snackbar("Locality Is Important",
                                    "Please Fill Locality");
                                return;
                              }
                              await createAddressInformation();
                              Get.to(WorkProfileScreen());
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
