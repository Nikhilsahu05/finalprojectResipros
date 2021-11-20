import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ManageAddressScreen extends StatefulWidget {
  const ManageAddressScreen({Key? key}) : super(key: key);

  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String subHeadingAddress = "";
  Future callAddressData() async {
    firebaseFirestore
        .collection("Full_Address")
        .doc(firebaseAuth.currentUser?.uid)
        .snapshots()
        .listen((event) {
      print(
          "${event["House_Number"]}, ${event["Locality"]}, ${event["District"]}");
      setState(() {
        subHeadingAddress =
            "${event["House_Number"]}, ${event["Locality"]}, ${event["District"]}";
      });
    });
  }

  @override
  void initState() {
    callAddressData();
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
            "Manage Address",
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
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: Color(0xff4d61a8),
            onPressed: () {
              Get.to(EditAddressScreen());
            },
            child: Icon(Icons.add),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Get.to(EditAddressScreen());
                },
                leading: Icon(
                  Icons.home,
                  size: 35,
                  color: Color(0xff4d61a8),
                ),
                title: Text("Home / Work"),
                subtitle: Text("$subHeadingAddress"),
                trailing: Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class EditAddressScreen extends StatefulWidget {
  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  TextEditingController houseNumber = TextEditingController();
  TextEditingController locality = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController pincode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Add New Address ?",
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
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
                      ))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
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
                        child: TextField(
                          controller: locality,
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
                                borderSide: BorderSide(
                                    width: 1.5, color: Color(0xff00adb5)),
                              )),
                        ),
                      ))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
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
                        child: TextField(
                          controller: district,
                          onSubmitted: (value) {},
                          decoration: InputDecoration(
                              fillColor: Colors.red,
                              hintMaxLines: 3,
                              labelText: 'District',
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
                      ))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
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
                        child: TextField(
                          controller: pincode,
                          onSubmitted: (value) {},
                          decoration: InputDecoration(
                              fillColor: Colors.red,
                              hintMaxLines: 3,
                              labelText: 'Pin Code',
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
                      ))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
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
                        child: TextField(
                          controller: state,
                          onSubmitted: (value) {},
                          decoration: InputDecoration(
                              fillColor: Colors.red,
                              hintMaxLines: 3,
                              labelText: 'State',
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
                      ))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
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
                    style: ElevatedButton.styleFrom(primary: Color(0xFF4D61A8)),
                    onPressed: () {},
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
    );
  }
}
