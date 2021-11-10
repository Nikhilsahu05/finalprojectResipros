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
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            Get.to(EditAddressScreen());
          },
          child: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        title: Text("Manage Addresses"),
        centerTitle: true,
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
            color: Colors.blue,
          ),
          title: Text("Home"),
          subtitle: Text("A-1,Saheb Parishar, Yadav Colony"),
          trailing: Icon(Icons.edit),
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
                              BorderSide(width: 1.5, color: Colors.blue),
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
                              BorderSide(width: 1.5, color: Colors.blue),
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
                              BorderSide(width: 1.5, color: Colors.blue),
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
                              BorderSide(width: 1.5, color: Colors.blue),
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
