import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:resipros/screens/work_profile_screen.dart';

class FullAddressScreen extends StatefulWidget {
  const FullAddressScreen({Key? key}) : super(key: key);

  @override
  _FullAddressScreenState createState() => _FullAddressScreenState();
}

class _FullAddressScreenState extends State<FullAddressScreen> {
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
        body: Column(
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
              child: const Text(
                "482002",
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFEBEBEB),
                      border: Border.all(color: Colors.white)),
                  height: 45,
                  child: TextField(
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
                          borderSide:
                              BorderSide(width: 1.5, color: Color(0xff00adb5)),
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFEBEBEB),
                      border: Border.all(color: Colors.white)),
                  height: 45,
                  child: TextField(
                    onSubmitted: (value) {},
                    decoration: InputDecoration(
                        fillColor: Colors.red,
                        hintMaxLines: 3,
                        labelText: 'Locality',
                        labelStyle:
                            TextStyle(fontSize: 13, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Color(0xff00adb5)),
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
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
                          child: Text("District"),
                        ))),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
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
                          child: Text("State"),
                        ))),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xFF4D61A8)),
                      onPressed: () {
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
