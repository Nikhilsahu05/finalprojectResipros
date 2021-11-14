import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ManageAddressScreen extends StatefulWidget {
  const ManageAddressScreen({Key? key}) : super(key: key);

  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
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
          child: ListTile(
            onTap: () {
              Get.to(EditAddressScreen());
            },
            leading: Icon(
              Icons.home,
              size: 35,
              color: Color(0xff4d61a8),
            ),
            title: Text("Home"),
            subtitle: Text("A-1,Saheb Parishar, Yadav Colony"),
            trailing: Icon(
              Icons.edit,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({Key? key}) : super(key: key);

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Address"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.network(
                "https://i.stack.imgur.com/yZKgB.png",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Center(
                child: Container(
                  height: 45,
                  child: TextField(
                    onSubmitted: (value) {},
                    decoration: InputDecoration(
                        hintMaxLines: 3,
                        labelText: "Tag (Eg. Home, Office)",
                        labelStyle: TextStyle(fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Color(0xff4d61a8)),
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Center(
                child: Container(
                  height: 45,
                  child: TextField(
                    onSubmitted: (value) {},
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
                              BorderSide(width: 1.5, color: Color(0xff4d61a8)),
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Center(
                child: Container(
                  height: 45,
                  child: TextField(
                    onSubmitted: (value) {},
                    decoration: InputDecoration(
                        hintMaxLines: 3,
                        labelText: 'Full Address',
                        labelStyle: TextStyle(fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Color(0xff4d61a8)),
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Center(
                child: Container(
                  height: 45,
                  child: TextField(
                    onSubmitted: (value) {},
                    decoration: InputDecoration(
                        hintMaxLines: 3,
                        labelText: 'Pin Code',
                        labelStyle: TextStyle(fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Color(0xff4d61a8)),
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Save Changs"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
