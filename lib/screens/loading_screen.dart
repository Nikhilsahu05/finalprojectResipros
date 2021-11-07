import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:resipros/screens/home_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int timer = 6;
  Future timerCountDown() async {
    await Future.delayed(Duration(seconds: 5));
    print(timer);
    setState(() {
      timer = 0;
    });
  }

  @override
  void initState() {
    timerCountDown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return timer == 0
        ? HomeScreen()
        : Material(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpinKitDoubleBounce(
                    color: Colors.blue,
                    size: 150,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Please Wait! While Analysing Your Data...",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
  }
}
