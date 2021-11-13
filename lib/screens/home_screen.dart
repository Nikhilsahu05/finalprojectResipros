import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:resipros/screens/settings_profile_screen.dart';

import 'manage_address_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String profileImageUrl = "https://via.placeholder.com/150";
String gridImageUrl =
    "https://5.imimg.com/data5/AT/BW/JN/ANDROID-36401672/product-jpeg-500x500.jpg";
String fullNameDashboard = "Full Name";
String phoneNumberDashboard = "xxx xxx xxxx";
String refferalCodeDashboard = "xx xxxx";

class _HomeScreenState extends State<HomeScreen> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 1);

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
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Dashboard"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  void initState() {
    print("  $profileImageUrl =====> Woooooo got image url");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeIn,
        child: PersistentTabView(
          context,
          controller: _controller,
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
                leading: Icon(Icons.update),
                onTap: () {
                  print("Latest Option Tapped");
                },
                title: Text("Latest"),
                trailing: Icon(
                  Icons.chevron_right,
                  size: 35,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  print("Reviews Option Tapped");
                },
                title: Text("Reviews"),
                trailing: Icon(
                  Icons.chevron_right,
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
                },
                title: Text("Photos Uploaded"),
                trailing: Icon(
                  Icons.chevron_right,
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
                },
                title: Text("Profile Views"),
                leading: Icon(
                  Icons.visibility,
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
        appBar: AppBar(
          title: Text("Notification"),
          centerTitle: true,
        ),
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
                      color: Color(0xff1f1f1f),
                      elevation: 8,
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Expanded(
                              flex: 3,
                              child: CircleAvatar(
                                child: CachedNetworkImage(
                                  imageUrl: profileImageUrl,
                                ),
                                maxRadius: 45,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 22.0, top: 45.0),
                                  child: Text(
                                    "PhoolChand Swami",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 35.0, top: 18.0),
                                  child: Text(
                                    "+91 8349337625",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 32.0),
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
                                              : Color(0xff00adb5),
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
                    ),
                  ),
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
                        "Posted By Customer",
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.chevron_right,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: 3,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 3),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              child: Image.network(
                                gridImageUrl,
                                height: 50,
                                width: 50,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.collections,
                          size: 35,
                        )),
                  ),
                ],
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
          title: Text("Settings"),
          centerTitle: true,
        ),
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
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                  horizontalTitleGap: 20,
                  leading: Icon(
                    Icons.notifications_active,
                    color: Colors.blue,
                  ),
                  title: Text("Notifications"),
                  subtitle: Text("Turn on/off Notification"),
                  trailing: Switch(
                    onChanged: (bool value) {
                      setState(() {
                        print(value);
                        valueNotification = value;
                      });
                    },
                    value: valueNotification,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                horizontalTitleGap: 20,
                leading: Icon(
                  Icons.home,
                  color: Colors.blue,
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
                  color: Colors.blue,
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
                  color: Colors.blue,
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
                  color: Colors.blue,
                ),
                onTap: () {
                  print("Settings Report  Option Tapped");
                },
                title: Text("Report"),
                subtitle: Text("Report any Anonymous Activity"),
                trailing: Icon(
                  Icons.chevron_right,
                  size: 35,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.logout),
                      Text("Logout"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
//Call All The Data Here
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
