import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String profileImageUrl = "https://via.placeholder.com/150";

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeIn,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text("Dashboard"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      color: Color(0xFFFFFDD0),
                      elevation: 8,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 15.0,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Full Name",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(profileImageUrl),
                                  maxRadius: 55,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 150,
                                height: 50,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (itemBuilder, index) {
                                      return Icon(
                                        Icons.star,
                                        color: index == 4
                                            ? Colors.grey.shade400
                                            : Colors.amber,
                                        size: 30,
                                      );
                                    }),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 15.0),
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "Refferal Code",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 15.0),
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "+91 8349337625",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Member Ship Plan"),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Work Uploaded By Customer",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      child: Image.network(
                        profileImageUrl,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Divider(
                  thickness: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
