import 'package:flutter/material.dart';

class PhotosByCustomer extends StatefulWidget {
  const PhotosByCustomer({Key? key}) : super(key: key);

  @override
  _PhotosByCustomerState createState() => _PhotosByCustomerState();
}

class _PhotosByCustomerState extends State<PhotosByCustomer> {
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
              "Photos By Customer",
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
        ));
  }
}
