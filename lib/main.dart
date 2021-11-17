import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resipros/screens/credentials/login/registration_screen.dart';
import 'package:resipros/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
        // Before: MaterialApp(
        home: MyAppStateful()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyAppStateful(),
    );
  }
}

class MyAppStateful extends StatefulWidget {
  const MyAppStateful({Key? key}) : super(key: key);

  @override
  _MyAppStatefulState createState() => _MyAppStatefulState();
}

class _MyAppStatefulState extends State<MyAppStateful> {
  late StreamSubscription<User?> user;
  bool isLoggedIn = false;

  @override
  void initState() {
    final user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          isLoggedIn = false;
        });
      } else {
        print('User is signed in!');
        setState(() {
          isLoggedIn = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: isLoggedIn ? LoadingScreen() : RegistrationScreen(),
      ),
    );
  }
}
