import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resipros/screens/onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MaterialApp(
        home: MyAppStateful(),
      ),
    );
  }
}

class MyAppStateful extends StatefulWidget {
  const MyAppStateful({Key? key}) : super(key: key);

  @override
  _MyAppStatefulState createState() => _MyAppStatefulState();
}

class _MyAppStatefulState extends State<MyAppStateful> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MaterialApp(
        home: Scaffold(
          body: OnboardingScreen(),
        ),
      ),
    );
  }
}
