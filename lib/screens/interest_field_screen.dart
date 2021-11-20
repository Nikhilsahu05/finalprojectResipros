import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'home_screen.dart';

class InterestFieldScreen extends StatefulWidget {
  const InterestFieldScreen({Key? key}) : super(key: key);

  @override
  _InterestFieldScreenState createState() => _InterestFieldScreenState();
}

class _InterestFieldScreenState extends State<InterestFieldScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future createSuperiorityInformation() async {
    await firebaseFirestore
        .collection("Superiority")
        .doc("${firebaseAuth.currentUser!.uid}")
        .set({
      "Construction&Repairing": CheckboxConstruction,
      "Building": CheckboxBuilding,
      "BuildingResidential": CheckboxResidential,
      "BuildingCommercial": CheckboxCommercial,
      "Repairing": CheckboxConstructionRepairing,
      "InteriorDesigner": CheckboxInterior,
      "Painter": CheckboxPainter,
      "Plumber": CheckboxPlumber,
      "PlumberFullFitting": CheckboxPlumberFitting,
      "PlumberFullRepairing": CheckboxPlumberRepairing,
      "Electrician": CheckboxElectrician,
      "ElectricianFullFitting": CheckboxElectricianFitting,
      "ElectricianRepairing": CheckboxElectricianRepairing,
      "OtherTypesOfWork": selectedWorkType,
    }).then((value) {
      print("INTEREST FIELD DATABASE SAVED");
    }).catchError((onError) {
      print("INTEREST FIELD DATABASE Error ===$onError");
    });
  }

  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  bool isLoading = false;

  var CheckboxOther = false;

  var CheckboxConstruction = false;
  var CheckboxInterior = false;

  var CheckboxPlumber = false;

  var CheckboxElectrician = false;

  var CheckboxPainter = false;

  var CheckboxBuilding = false;

  var CheckboxResidential = false;

  var CheckboxCommercial = false;

  var CheckboxConstructionRepairing = false;

  var CheckboxPlumberFitting = false;

  var CheckboxPlumberRepairing = false;

  var CheckboxElectricianRepairing = false;

  var CheckboxElectricianFitting = false;

  List<String> typesOfWork = [
    'Carpentry',
    'Plasterwork',
    'Steel construction ',
    "Sheet metal ",
    "Glass work",
    "Coating work",
    "Waterproofing ",
    "Thermal insulation ",
    "Landscape gardening",
    "Firefighting facilities ",
    "Waste facilities ",
    "Water facilities ",
  ];

  List selectedWorkType = [];
  ScrollController _scrollController = new ScrollController(
    keepScrollOffset: true,
  );

  bool isloadingDialog = false;

  FocusNode? myFocusNode;

  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentText = "";
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
        body: isLoading == true
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: SpinKitFadingCube(
                  color: Colors.blueAccent,
                  size: 100.0,
                )),
              )
            : SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  height: MediaQuery.of(context).size.height * 1.8,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "You Are Interested In ?",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: Color(0xff00adb5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              value: CheckboxConstruction,
                              onChanged: (newValue) {
                                setState(() {
                                  CheckboxConstruction = newValue!;
                                });
                                if (CheckboxConstruction == false) {
                                  setState(() {
                                    CheckboxBuilding = false;

                                    CheckboxResidential = false;

                                    CheckboxCommercial = false;

                                    CheckboxConstructionRepairing = false;
                                  });
                                }
                              },
                            ),
                            Text(
                              "Construction & Repairing",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45.0),
                        child: Visibility(
                          visible: CheckboxConstruction,
                          child: FadeIn(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  activeColor: Color(0xff00adb5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  value: CheckboxBuilding,
                                  onChanged: (newValue) {
                                    setState(() {
                                      CheckboxBuilding = newValue!;
                                    });
                                    if (CheckboxBuilding == false) {
                                      setState(() {
                                        CheckboxResidential = false;
                                        CheckboxCommercial = false;
                                      });
                                    }
                                  },
                                ),
                                Text("Building ",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: CheckboxBuilding == true &&
                            CheckboxConstruction == true,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: FadeIn(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  activeColor: Color(0xff00adb5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  value: CheckboxResidential,
                                  onChanged: (newValue) {
                                    setState(() {
                                      CheckboxResidential = newValue!;
                                    });
                                  },
                                ),
                                Text("Residential",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: CheckboxBuilding == true &&
                            CheckboxConstruction == true,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: FadeIn(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  activeColor: Color(0xff00adb5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  value: CheckboxCommercial,
                                  onChanged: (newValue) {
                                    setState(() {
                                      CheckboxCommercial = newValue!;
                                    });
                                  },
                                ),
                                Text("Commercial",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: CheckboxConstruction == true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45),
                          child: FadeIn(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  activeColor: Color(0xff00adb5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  value: CheckboxConstructionRepairing,
                                  onChanged: (newValue) {
                                    setState(() {
                                      CheckboxConstructionRepairing = newValue!;
                                    });
                                  },
                                ),
                                Text("Repairing ",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              activeColor: Color(0xff00adb5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              value: CheckboxInterior,
                              onChanged: (newValue) {
                                setState(() {
                                  CheckboxInterior = newValue!;
                                });
                              },
                            ),
                            Text(
                              "Interior Designer",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: Color(0xff00adb5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              value: CheckboxPainter,
                              onChanged: (newValue) {
                                setState(() {
                                  CheckboxPainter = newValue!;
                                });
                              },
                            ),
                            Text(
                              "Painter",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: Color(0xff00adb5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              value: CheckboxPlumber,
                              onChanged: (newValue) {
                                setState(() {
                                  CheckboxPlumber = newValue!;
                                });
                                if (CheckboxPlumber == false) {
                                  setState(() {
                                    CheckboxPlumberFitting = false;
                                    CheckboxPlumberRepairing = false;
                                  });
                                }
                              },
                            ),
                            Text(
                              "Plumber",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: CheckboxPlumber == true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45),
                          child: FadeIn(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Checkbox(
                                    activeColor: Color(0xff00adb5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    value: CheckboxPlumberFitting,
                                    onChanged: (newValue) {
                                      setState(() {
                                        CheckboxPlumberFitting = newValue!;
                                      });
                                    },
                                  ),
                                  Text("Full Fitting ",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: CheckboxPlumber == true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45),
                          child: FadeIn(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Checkbox(
                                    activeColor: Color(0xff00adb5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    value: CheckboxPlumberRepairing,
                                    onChanged: (newValue) {
                                      setState(() {
                                        CheckboxPlumberRepairing = newValue!;
                                      });
                                    },
                                  ),
                                  Text("Repairing",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: Color(0xff00adb5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              value: CheckboxElectrician,
                              onChanged: (newValue) {
                                setState(() {
                                  CheckboxElectrician = newValue!;
                                });
                                if (CheckboxElectrician == false) {
                                  setState(() {
                                    CheckboxElectricianFitting = false;
                                    CheckboxElectricianRepairing = false;
                                  });
                                }
                              },
                            ),
                            Text(
                              "Electrician",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: CheckboxElectrician == true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45),
                          child: FadeIn(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Checkbox(
                                    activeColor: Color(0xff00adb5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    value: CheckboxElectricianFitting,
                                    onChanged: (newValue) {
                                      setState(() {
                                        CheckboxElectricianFitting = newValue!;
                                      });
                                    },
                                  ),
                                  Text("Full Fitting",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: CheckboxElectrician == true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45),
                          child: FadeIn(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: Color(0xff00adb5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  value: CheckboxElectricianRepairing,
                                  onChanged: (newValue) {
                                    setState(() {
                                      CheckboxElectricianRepairing = newValue!;
                                    });
                                  },
                                ),
                                Text("Repairing",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: Color(0xff00adb5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),

                              value: CheckboxOther,
                              onChanged: (newValue) {
                                setState(() {
                                  myFocusNode!.requestFocus();
                                  CheckboxOther = newValue!;
                                  _scrollController.jumpTo(300);
                                  print(_scrollController.offset);
                                });
                              },
                              //  <-- leading Checkbox
                            ),
                            Text(
                              "Other Fields",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: CheckboxOther == true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 18),
                          child: Center(
                            child: FadeIn(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                              child: Container(
                                height: 45,
                                child: SimpleAutoCompleteTextField(
                                  focusNode: myFocusNode,
                                  key: key,
                                  suggestions: typesOfWork,
                                  decoration: InputDecoration(
                                    hintText: 'Types Of Work',
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                  clearOnSubmit: true,
                                  textChanged: (text) => currentText = text,
                                  textSubmitted: (text) => setState(() {
                                    myFocusNode!.requestFocus();
                                    if (text != "") {
                                      selectedWorkType.add(text);
                                      setState(() {
                                        typesOfWork.remove(text);
                                      });
                                    }
                                  }),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: CheckboxOther == true,
                        child: Flexible(
                          child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: selectedWorkType.length,
                            itemBuilder: (itemBuilder, context) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            var value = selectedWorkType
                                                .removeAt(context);
                                            print(value);
                                            typesOfWork.add(value);
                                          });
                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 10.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.deepOrangeAccent,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0),
                                              ),
                                              child: Text(
                                                '${selectedWorkType[context]}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.orange.shade600,
                                                radius: 8.0,
                                                child: Icon(
                                                  Icons.clear,
                                                  size: 10.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 18),
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF4D61A8)),
                                onPressed: () async {
                                  if (CheckboxOther ||
                                      CheckboxConstruction ||
                                      CheckboxInterior ||
                                      CheckboxPlumber ||
                                      CheckboxElectrician ||
                                      CheckboxPainter ||
                                      CheckboxBuilding ||
                                      CheckboxResidential ||
                                      CheckboxCommercial ||
                                      CheckboxConstructionRepairing ||
                                      CheckboxPlumberFitting ||
                                      CheckboxPlumberRepairing ||
                                      CheckboxElectricianRepairing ||
                                      CheckboxElectricianFitting == true) {
                                    if (CheckboxConstruction == true) {
                                      if (CheckboxBuilding ||
                                          CheckboxConstructionRepairing ==
                                              true) {
                                      } else {
                                        Get.snackbar("Please Select",
                                            "Atlease One Field = Building or Repairing");
                                        return;
                                      }
                                      if (CheckboxBuilding == true) {
                                        if (CheckboxResidential ||
                                            CheckboxCommercial == true) {
                                        } else {
                                          Get.snackbar("Please Select",
                                              "Atlease One Field = Residential  or Commercial");
                                          return;
                                        }
                                      }
                                    }
                                    if (CheckboxPlumber == true) {
                                      if (CheckboxPlumberFitting ||
                                          CheckboxPlumberRepairing == true) {
                                      } else {
                                        Get.snackbar("Please Select",
                                            "Atlease One Field = Full Fitting or Repairing");
                                        return;
                                      }
                                    }
                                    if (CheckboxElectrician == true) {
                                      if (CheckboxElectricianFitting ||
                                          CheckboxElectricianRepairing ==
                                              true) {
                                      } else {
                                        Get.snackbar("Please Select",
                                            "Atlease One Field = Full Fitting or Repairing");
                                        return;
                                      }
                                    }
                                  } else {
                                    print("No field is set to tru");
                                    Get.snackbar("Select Atleast one field",
                                        "No Field is selected");
                                    return;
                                  }
                                  await createSuperiorityInformation();
                                  Get.to(LoadingScreen());
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Confirm",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
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
            "Superiority",
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
