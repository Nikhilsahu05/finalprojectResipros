import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:resipros/screens/database_services.dart';

import 'interest_field_screen.dart';

class WorkProfileScreen extends StatefulWidget {
  @override
  _WorkProfileScreenState createState() => _WorkProfileScreenState();
}

class _WorkProfileScreenState extends State<WorkProfileScreen> {
  bool _showIndicator = false;

  void setWorkInformationdb() {
    setState(() {
      _showIndicator = true;
    });
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firebasedb = FirebaseFirestore.instance;
    try {
      _firebasedb
          .collection(_auth.currentUser!.uid)
          .doc("work_information")
          .set({
        "Experience": _selectedExperience,
        'Skills': _selectedType,
        "BasisOfWorkDay": checkboxDay,
        "BasisOfWorkInch": checkboxInch,
        "BasisOfWorkContract": checkboxContract,
        "PerDayRangeFrom": _dayPriceRangeFirst.text,
        "PerDayRangeTo": _dayPriceRangeSecond.text,
        "PerInchRangeFrom": _InchPriceRangeFirst.text,
        "PerInchRangeTo": _InchPriceRangeSecond.text,
      }).then((res) {
        setState(() {
          _showIndicator = false;
        });
        print("setWorkInformationdb Success");
      }).catchError((onError) {
        print('problem on updating data == > $onError');
      });
    } on Exception catch (e) {
      print("Exeption on Updating Data ===> Work Profile + $e");
    }
  }

  List _experience = ['0 - 5 years', '5-10 years', '10-15 years', '15+ years'];
  List _type = [
    'Fresher',
    'Intermediate',
    'Expert',
  ];

  var _selectedExperience;
  var _selectedType;

  TextEditingController _expectedWagesController = TextEditingController();

  bool checkboxDay = false;
  bool checkboxInch = false;
  bool checkboxContract = false;

  TextEditingController _dayPriceRangeFirst = TextEditingController();
  TextEditingController _dayPriceRangeSecond = TextEditingController();

  TextEditingController _InchPriceRangeSecond = TextEditingController();

  TextEditingController _InchPriceRangeFirst = TextEditingController();
  DataBaseServices _dataBaseServices = DataBaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Work Information"),
      ),
      body: SingleChildScrollView(
        child: _showIndicator
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
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Experience",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15),
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
                              hint: const Text("Select Experience"),
                              value: _selectedExperience,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedExperience = newValue;
                                  _experience;
                                  Get.snackbar(
                                      "$_selectedExperience Experience",
                                      "Your Selected Experence is $_selectedExperience");
                                  print(_selectedExperience);
                                });
                              },
                              items: _experience.map((map) {
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Type",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15),
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
                              hint: const Text("Select Type"),
                              value: _selectedType,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedType = newValue;
                                  Get.snackbar("$_selectedType Type",
                                      "Your Selected Type is $_selectedType");
                                  print(_selectedType);
                                });
                              },
                              items: _type.map((map) {
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Basis of Work",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    title: Text("Per Day Basis"),
                    value: checkboxDay,
                    onChanged: (newValue) {
                      setState(() {
                        checkboxDay = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  CheckboxListTile(
                    title: Text("Per Inch Basis"),
                    value: checkboxInch,
                    onChanged: (newValue) {
                      setState(() {
                        checkboxInch = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  CheckboxListTile(
                    title: Text("Contract Basis"),
                    value: checkboxContract,
                    onChanged: (newValue) {
                      setState(() {
                        checkboxContract = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  checkboxDay == true
                      ? FadeIn(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Container(
                                      height: 45,
                                      child: TextField(
                                        controller: _dayPriceRangeFirst,
                                        onSubmitted: (value) {
                                          _dayPriceRangeFirst.text = value;
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            prefixText: "₹ ",
                                            hintMaxLines: 3,
                                            hintText: "100",
                                            labelStyle: TextStyle(fontSize: 13),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.blue),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 18,
                                child: Divider(
                                  thickness: 2.25,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              Container(
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Container(
                                      height: 45,
                                      child: TextField(
                                        controller: _dayPriceRangeSecond,
                                        onSubmitted: (value) {
                                          _dayPriceRangeSecond.text = value;
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            prefixText: "₹ ",
                                            hintMaxLines: 3,
                                            hintText: "1000",
                                            helperStyle: TextStyle(),
                                            labelStyle: TextStyle(fontSize: 13),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.blue),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Per Day",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(""),
                  SizedBox(
                    height: 12,
                  ),
                  checkboxInch == true
                      ? FadeIn(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Container(
                                      height: 45,
                                      child: TextField(
                                        controller: _InchPriceRangeFirst,
                                        onSubmitted: (value) {
                                          _InchPriceRangeFirst.text = value;
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            prefixText: "₹ ",
                                            hintMaxLines: 3,
                                            hintText: "100",
                                            labelStyle: TextStyle(fontSize: 13),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.blue),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 18,
                                child: Divider(
                                  thickness: 2.25,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              Container(
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Container(
                                      height: 45,
                                      child: TextField(
                                        controller: _InchPriceRangeSecond,
                                        onSubmitted: (value) {
                                          _InchPriceRangeSecond.text = value;
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            prefixText: "₹ ",
                                            hintMaxLines: 3,
                                            hintText: "1000",
                                            helperStyle: TextStyle(),
                                            labelStyle: TextStyle(fontSize: 13),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.blue),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Per Inch",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(""),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          if (_selectedExperience == null) {
                            return Get.snackbar(
                                "Invalid", "Please Select Experience");
                          }
                          if (_selectedType == null) {
                            return Get.snackbar(
                                "Invalid", "Please Select Type");
                          }
                          if (checkboxDay == false &&
                              checkboxInch == false &&
                              checkboxContract == false) {
                            return Get.snackbar("Invalid",
                                "Please Select Atleast 1 Basis of Work");
                          }
                          if (checkboxDay == true) {
                            if (_dayPriceRangeFirst.text == null) {
                              return Get.snackbar(
                                  "Invalid", "Please Enter Price Range");
                            }
                            if (_dayPriceRangeSecond.text == null) {
                              return Get.snackbar(
                                  "Invalid", "Please Enter Price Range");
                            }
                          }
                          if (checkboxInch == true) {
                            if (_InchPriceRangeFirst.text == null) {
                              return Get.snackbar(
                                  "Invalid", "Please Enter Price Range");
                            }
                            if (_InchPriceRangeSecond.text == null) {
                              return Get.snackbar(
                                  "Invalid", "Please Enter Price Range");
                            }
                          }
                          setWorkInformationdb();
                          Get.offAll(InterestFieldScreen());
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
      ),
    );
  }
}
//TODO: Phone number confirm field remove padding gesture detector
