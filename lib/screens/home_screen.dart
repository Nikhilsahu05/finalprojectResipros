import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:resipros/screens/dashboard/dashboard_photos_by_cutomer.dart';
import 'package:resipros/screens/home_screen_reviews_screen.dart';
import 'package:resipros/screens/settings_profile_screen.dart';

import 'credentials/login/registration_screen.dart';
import 'dashboard/dashboard_photos_by_you.dart';
import 'manage_address_screen.dart';
import 'membership_plan_screen.dart';
import 'notifications_profile_view_screen.dart';

String profileImageUrl = "";
String gridImageUrl =
    "https://5.imimg.com/data5/AT/BW/JN/ANDROID-36401672/product-jpeg-500x500.jpg";
String fullNameDashboard = "";
String phoneNumberDashboard = "";

List postedByCustomer = [];

PersistentTabController controller = PersistentTabController(initialIndex: 1);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _screens = [
    NotificationScreen(),
    DashboardScreen(),
    SettingsScreen()
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications),
        title: ("Notification"),
        activeColorPrimary: Color(0xff00adb5),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Dashboard"),
        activeColorPrimary: Color(0xff00adb5),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: Color(0xff00adb5),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  void initState() {
    print("HomeScreen Started");
    super.initState();
  }

  @override
  void dispose() {
    print("HomeScreen Closed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeIn,
        child: PersistentTabView(
          context,

          controller: controller,
          screens: _screens,
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 300),
          ),
          navBarStyle: NavBarStyle
              .style9, // Choose the nav bar style with this property.
        ));
  }
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    print("NotificationScreen Started");
    super.initState();
  }

  @override
  void dispose() {
    print("NotificationScreen Closed");
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
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  print("Reviews Option Tapped");

                  Get.to(HomeScreenReviewsScreen());
                },
                title: Text("Reviews"),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 35,
                ),
                leading: Icon(
                  Icons.reviews,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  print("Photos Uploaded Option Tapped");
                  Get.to(PhotosByCustomer());
                },
                title: Text("Photos By Customer"),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 35,
                ),
                leading: Icon(
                  Icons.add_to_photos,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  print("Profile Views Option Tapped");
                  Get.to(NotificationsProfileViewScreen());
                },
                title: Text("Profile Views"),
                leading: Icon(
                  Icons.visibility,
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 35,
                ),
              ),
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
            onPressed: () => Get.to(HomeScreen()),
          ),
          title: Text(
            "Notifications",
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

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    print("DashboardScreen Started");
    super.initState();
  }

  @override
  void dispose() {
    print("DashboardScreen Closed");
    super.dispose();
  }

  List<Widget> _listOfPostedByCustomer = [
    Container(
      height: 100,
      width: 100,
      child: Image.network(
        "https://5.imimg.com/data5/AT/BW/JN/ANDROID-36401672/product-jpeg-500x500.jpg",
        fit: BoxFit.fill,
      ),
    ),
    Container(
      child: Image.network(
        "https://miro.medium.com/max/1200/1*P59574JT5sw1wEgSIxeQAQ.jpeg",
        fit: BoxFit.fill,
      ),
    ),
    Container(
      child: Image.network(
        'https://cdn.pixabay.com/photo/2017/08/03/21/37/construction-2578410_960_720.jpg',
        fit: BoxFit.fill,
      ),
    ),
    Container(
      child: IconButton(
        icon: Icon(
          Icons.collections,
          size: 35,
        ),
        onPressed: () {
          Get.to(PhotosByCustomer());
          print("Album Icon Pressed");
        },
      ),
    )
  ];

  List<Widget> _listOfPostedByYou = [
    Container(
      child: Image.network(
        "https://5.imimg.com/data5/AT/BW/JN/ANDROID-36401672/product-jpeg-500x500.jpg",
        fit: BoxFit.fill,
      ),
    ),
    Container(
      child: Image.network(
        "https://miro.medium.com/max/1200/1*P59574JT5sw1wEgSIxeQAQ.jpeg",
        fit: BoxFit.fill,
      ),
    ),
    Container(
      child: Image.network(
        'https://cdn.pixabay.com/photo/2017/08/03/21/37/construction-2578410_960_720.jpg',
        fit: BoxFit.fill,
      ),
    ),
    Container(
      child: IconButton(
        icon: Icon(
          Icons.collections,
          size: 35,
        ),
        onPressed: () {
          Get.to(PhotosByYou());
          print("Album Icon Pressed");
        },
      ),
    )
  ];
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Dashboard",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Karla",
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 80,
              ),
              IconButton(
                icon: Icon(
                  Icons.power_settings_new,
                  color: Colors.black,
                  size: 32,
                ),
                onPressed: () => exit(0),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    color: Color(0xff1f1f1f),
                    elevation: 8,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 25),
                              child: Flexible(
                                flex: 3,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(profileImageUrl),
                                  maxRadius: 45,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 7,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 42.0, top: 45.0),
                                        child: Text(
                                          "$fullNameDashboard",
                                          style: TextStyle(
                                              letterSpacing: 2.0,
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 18.0,
                                          ),
                                          child: Container(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                              onPressed: () {
                                                Get.to(NotificationScreen());
                                              },
                                              icon: Icon(Icons.notifications),
                                              color: Color(0xffebebeb),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 35.0, top: 18.0),
                                    child: Text(
                                      "$phoneNumberDashboard",
                                      style: TextStyle(
                                          letterSpacing: 2.0,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                    alignment: Alignment.centerLeft,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 50.0),
                                    height: 60,
                                    width: 300,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          child: Icon(
                                            Icons.star,
                                            size: 25,
                                            color: index == 4
                                                ? Colors.grey
                                                : Colors.amber,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              Get.to(MembershipPlanScreen());
                            },
                            child: const Text(
                              "REGULAR MEMBERSHIP",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 6.0,
                                  color: Color(0xff00adb5)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Photos By You",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(""),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 8.0),
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Get.to(PhotosByYou());
                      },
                      icon: Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _listOfPostedByYou[index];
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Photos By Customer",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(""),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 8.0),
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Get.to(PhotosByCustomer());
                      },
                      icon: Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _listOfPostedByCustomer[index];
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Reviews By Customer",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(""),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 8.0),
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Get.to(HomeScreenReviewsScreen());
                      },
                      icon: Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Using for a day. So far all Good. Back side Diamond finish great. Material also Good. Camera - Good, bright picture. Rich in color may be corrected. Display Good.",
                    textAlign: TextAlign.justify,
                  ),
                ),
                leading: Icon(Icons.account_circle),
                title: Text(
                  "Nikhil Sahu",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Using for a day. So far all Good. Back side Diamond finish great. Material also Good. Camera - Good, bright picture. Rich in color may be corrected. Display Good.",
                    textAlign: TextAlign.justify,
                  ),
                ),
                leading: Icon(Icons.account_circle),
                title: Text(
                  "Akhil Sahu",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Using for a day. So far all Good. Back side Diamond finish great. Material also Good. Camera - Good, bright picture. Rich in color may be corrected. Display Good.",
                    textAlign: TextAlign.justify,
                  ),
                ),
                leading: Icon(Icons.account_circle),
                title: Text(
                  "Paras Maravi",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var valueNotification = false;

  @override
  void initState() {
    print("SettingsScreen Started");
    super.initState();
  }

  @override
  void dispose() {
    print("SettingsScreen Closed");
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
            onPressed: () => Get.to(HomeScreen()),
          ),
          title: Text(
            "Settings",
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
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                horizontalTitleGap: 20,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsProfileScreen()),
                  );
                  print("Settings tab profile Option Tapped");
                },
                title: Text("${fullNameDashboard}"),
                subtitle: Text("${phoneNumberDashboard}"),
                trailing: Text(
                  "Edit",
                  style: TextStyle(
                    color: Color(0xff4d61a8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                horizontalTitleGap: 20,
                leading: Icon(
                  Icons.gpp_good,
                  color: Color(0xff4d61a8),
                ),
                onTap: () {
                  Get.to(MembershipPlanScreen());
                  print("Settings tab MemberShip Plan Option Tapped");
                },
                title: Text('Membership PLan'),
                subtitle: Text("Select Valuable Plans"),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                horizontalTitleGap: 20,
                leading: Icon(
                  Icons.home,
                  color: Color(0xff4d61a8),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageAddressScreen()),
                  );

                  print("Settings tab Address Option Tapped");
                },
                title: Text("My Address"),
                subtitle: Text("Manage Work Addresses"),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                horizontalTitleGap: 20,
                leading: Icon(
                  Icons.contact_support,
                  color: Color(0xff4d61a8),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageAddressScreen()),
                  );

                  print("Contact us Option Tapped");
                },
                title: Text("Contact Us"),
                subtitle: Text("Feel free to contact us"),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                horizontalTitleGap: 20,
                leading: Icon(
                  Icons.contact_phone,
                  color: Color(0xff4d61a8),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageAddressScreen()),
                  );

                  print("About us Address Option Tapped");
                },
                title: Text("About us"),
                subtitle: Text("Know More About Resipros"),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                horizontalTitleGap: 20,
                leading: Icon(
                  Icons.report,
                  color: Color(0xff4d61a8),
                ),
                onTap: () {
                  print("Settings Report  Option Tapped");
                },
                title: Text("Report"),
                subtitle: Text("Report any Anonymous Activity"),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xFF4D61A8)),
                    onPressed: () {
                      Get.to(RegistrationScreen());
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.power_settings_new,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Logout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future readDashboardData() async {
    firebaseFirestore
        .collection(auth.currentUser!.uid)
        .doc("Profile_Information")
        .get()
        .then((value) {
      print(value.data());
      setState(() {
        profileImageUrl = value.data()!["ProfilePictureURL"];
        fullNameDashboard = value.data()!["Full_Name"];
        phoneNumberDashboard = value.data()!["Mobile_Number"];
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void initState() {
    readDashboardData();
    print("Loading Screen Started");
    print(profileImageUrl);
    timerCountDown();
    super.initState();
  }

  @override
  void dispose() {
    print("Loading Screen Closed");
    super.dispose();
  }

  int timer = 6;
  Future timerCountDown() async {
    await Future.delayed(Duration(seconds: 5));
    print(timer);
    setState(() {
      timer = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return timer == 0
        ? HomeScreen()
        : MaterialApp(
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
            home: Material(
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
            ),
          );
  }
}
