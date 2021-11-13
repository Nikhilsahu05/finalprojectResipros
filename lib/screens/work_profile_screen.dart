import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:resipros/screens/interest_field_screen.dart';

class WorkProfileScreen extends StatefulWidget {
  @override
  _WorkProfileScreenState createState() => _WorkProfileScreenState();
}

class _WorkProfileScreenState extends State<WorkProfileScreen> {
  bool _showIndicator = false;

  List _experience = ['0 - 5 Years', '5-10 Years', '10-15 Years', '15+ Years'];
  List _type = [
    'Fresher',
    'Intermediate',
    'Expert',
  ];

  var _selectedExperience;

  TextEditingController _expectedWagesController = TextEditingController();

  bool checkboxDay = true;
  bool checkboxInch = true;
  bool checkboxContract = true;

  TextEditingController _dayPriceRangeFirst = TextEditingController();
  TextEditingController _dayPriceRangeSecond = TextEditingController();

  TextEditingController _InchPriceRangeSecond = TextEditingController();

  TextEditingController _InchPriceRangeFirst = TextEditingController();

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
            "Work Information",
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
        body: _showIndicator
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
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Karla",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15),
                    child: Center(
                      child: Container(
                        color: Color(0xffebebeb),
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              dropdownColor: Color(0xffEBEBEB),
                              isDense: true,
                              hint: const Text(
                                "Select Experience",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14, fontFamily: "Karla"),
                              ),
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
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Basis of Work",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Karla",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Checkbox(
                        value: checkboxDay == true ? true : false,
                        onChanged: (onChanged) {
                          setState(() {
                            print(onChanged);
                            onChanged = checkboxDay;
                          });
                        },
                        activeColor: Color(0xff00adb5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      Text(
                        "Per Day Basis",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontFamily: "Karla"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        value: checkboxInch,
                        onChanged: (onChanged) {
                          setState(() {
                            onChanged = checkboxInch;
                          });
                        },
                        activeColor: Color(0xff00adb5),
                      ),
                      Text(
                        "Per Inch Basis",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontFamily: "Karla"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        value: checkboxContract,
                        onChanged: (onChanged) {
                          setState(() {
                            onChanged = checkboxContract;
                          });
                        },
                        activeColor: Color(0xff00adb5),
                      ),
                      Text(
                        "Contract Basis",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontFamily: "Karla"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  checkboxDay == true
                      ? FadeIn(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xffebebeb),
                                    ),
                                    height: 30,
                                    child: TextField(
                                      controller: _InchPriceRangeFirst,
                                      onSubmitted: (value) {
                                        _InchPriceRangeFirst.text = value;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          prefixText: "₹ ",
                                          hintMaxLines: 3,
                                          hintText: "(Atleast)",
                                          hintStyle: TextStyle(fontSize: 12),
                                          labelStyle: TextStyle(fontSize: 13),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color: Color(0xffebebe)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: Color(0xff00adb5)),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 10,
                                child: Divider(
                                  thickness: 1.5,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              Container(
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xffebebeb),
                                    ),
                                    height: 30,
                                    child: TextField(
                                      controller: _InchPriceRangeFirst,
                                      onSubmitted: (value) {
                                        _InchPriceRangeFirst.text = value;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          prefixText: "₹ ",
                                          hintMaxLines: 3,
                                          hintText: "(Atmost)",
                                          hintStyle: TextStyle(fontSize: 12),
                                          labelStyle: TextStyle(fontSize: 13),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color: Color(0xffebebe)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: Color(0xff00adb5)),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Per Day",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: "Karla"),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xffebebeb),
                                    ),
                                    height: 30,
                                    child: TextField(
                                      controller: _InchPriceRangeFirst,
                                      onSubmitted: (value) {
                                        _InchPriceRangeFirst.text = value;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          prefixText: "₹ ",
                                          hintMaxLines: 3,
                                          hintText: "(Atleast)",
                                          hintStyle: TextStyle(fontSize: 12),
                                          labelStyle: TextStyle(fontSize: 13),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color: Color(0xffebebe)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: Color(0xff00adb5)),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 10,
                                child: Divider(
                                  thickness: 1.5,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              Container(
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xffebebeb),
                                    ),
                                    height: 30,
                                    child: TextField(
                                      controller: _InchPriceRangeFirst,
                                      onSubmitted: (value) {
                                        _InchPriceRangeFirst.text = value;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          prefixText: "₹ ",
                                          hintMaxLines: 3,
                                          hintText: "(Atmost)",
                                          hintStyle: TextStyle(fontSize: 12),
                                          labelStyle: TextStyle(fontSize: 13),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color: Color(0xffebebe)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: Color(0xff00adb5)),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Per Inch",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: "Karla"),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(""),
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: 200,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 18, right: 18, bottom: 18),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFF4D61A8)),
                            onPressed: () {
                              Get.to(InterestFieldScreen());
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
//TODO: Phone number confirm field remove padding gesture detector
