import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resipros/screens/profile_screen.dart';

class RefferalCodeScreen extends StatefulWidget {
  String refferalCode;

  RefferalCodeScreen(this.refferalCode);

  @override
  _RefferalCodeScreenState createState() => _RefferalCodeScreenState();
}

class _RefferalCodeScreenState extends State<RefferalCodeScreen> {
  @override
  void initState() {
    super.initState();
  }

  String? uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        centerTitle: true,
        title: const Text("REFFERAL CODE",
            style: TextStyle(
                color: Colors.white70,
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2)),
      ),
      backgroundColor: Colors.black,
      body: Container(
          color: Colors.black,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text("Your Refferal Code",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2)),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "${widget.refferalCode.toUpperCase()}",
                  style: TextStyle(
                      color: Colors.blueAccent.shade700,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3.5),
                ),
                SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  child: Text(
                    "Proceed",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.57),
                  ),
                  onPressed: () {
                    Get.to(ProfileScreen());
                  },
                ),
              ],
            ),
          )),
    );
  }
}
