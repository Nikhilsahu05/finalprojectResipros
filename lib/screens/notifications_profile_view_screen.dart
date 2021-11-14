import 'package:flutter/material.dart';

class NotificationsProfileViewScreen extends StatefulWidget {
  const NotificationsProfileViewScreen({Key? key}) : super(key: key);

  @override
  _NotificationsProfileViewScreenState createState() =>
      _NotificationsProfileViewScreenState();
}

class _NotificationsProfileViewScreenState
    extends State<NotificationsProfileViewScreen> {
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 58.0),
                child: Text(
                  "Plans Comming Soon",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 3.25),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Icon(
                Icons.watch_later,
                size: 300,
                color: Color(0xffEbebeb),
              ),
            ),
            SizedBox(
              height: 150,
            ),
          ],
        ),
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
            "Profile Views",
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
      ),
    );
  }
}
