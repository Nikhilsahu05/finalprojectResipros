import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:resipros/screens/database_services.dart';

class InterestFieldScreen extends StatefulWidget {
  const InterestFieldScreen({Key? key}) : super(key: key);

  @override
  _InterestFieldScreenState createState() => _InterestFieldScreenState();
}

class _InterestFieldScreenState extends State<InterestFieldScreen> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  bool isLoading = false;
  var checkboxConstruction = false;

  var checkboxOther = false;

  var checkboxInterior = false;

  var checkboxPlumber = false;

  var checkboxElectrician = false;

  var checkboxPainter = false;

  var checkboxCarpainter = false;

  var checkboxBuilding = false;

  var checkboxResidential = false;

  var checkboxCommercial = false;

  var checkboxConstructionRepairing = false;

  var checkboxPlumberFitting = false;

  var checkboxPlumberRepairing = false;

  var checkboxElectricianRepairing = false;

  var checkboxElectricianFitting = false;

  List<String> typesOfWork = [
    'Carpentry',
    'Plasterwork',
    'Steel construction ',
    "Sheet metal ",
    "Glass ",
    "Coating ",
    "Waterproofing ",
    "Thermal insulation ",
    "Telecommunications ",
    "Landscape gardening",
    "Firefighting facilities ",
    "Waste facilities ",
    "Water facilities ",
  ];

  List selectedWorkType = [];

  bool isloadingDialog = false;

  ScrollController _controller = ScrollController();
  ScrollController _controllerScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    String currentText = "";
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.5,
          child: isLoading == true
              ? CircularProgressIndicator()
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "YOU ARE SUPERIOR IN ?",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    CheckboxListTile(
                      activeColor: Colors.green,
                      title:
                          Text("Construction & Repairing", style: TextStyle()),
                      value: checkboxConstruction,
                      onChanged: (newValue) {
                        setState(() {
                          checkboxConstruction = newValue!;
                        });
                        if (checkboxConstruction == false) {
                          setState(() {
                            checkboxBuilding = false;

                            checkboxResidential = false;

                            checkboxCommercial = false;

                            checkboxConstructionRepairing = false;
                          });
                        }
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45.0),
                      child: Visibility(
                        visible: checkboxConstruction,
                        child: FadeIn(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          child: CheckboxListTile(
                            activeColor: Colors.green,
                            title: Text("Building ",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                            value: checkboxBuilding,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxBuilding = newValue!;
                              });
                              if (checkboxBuilding == false) {
                                setState(() {
                                  checkboxResidential = false;
                                  checkboxCommercial = false;
                                });
                              }
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: checkboxBuilding == true &&
                          checkboxConstruction == true,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: FadeIn(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          child: CheckboxListTile(
                            activeColor: Colors.green,
                            title: Text("Residential",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                            value: checkboxResidential,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxResidential = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: checkboxBuilding == true &&
                          checkboxConstruction == true,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: FadeIn(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          child: CheckboxListTile(
                            activeColor: Colors.green,
                            title: Text("Commercial",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                            value: checkboxCommercial,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxCommercial = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: checkboxConstruction == true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: FadeIn(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          child: CheckboxListTile(
                            activeColor: Colors.green,
                            title: Text("Repairing ",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                            value: checkboxConstructionRepairing,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxConstructionRepairing = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                        ),
                      ),
                    ),
                    CheckboxListTile(
                      activeColor: Colors.green,
                      title: Text("Interior Designer"),
                      value: checkboxInterior,
                      onChanged: (newValue) {
                        setState(() {
                          checkboxInterior = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      activeColor: Colors.green,

                      title: Text("Painter"),
                      value: checkboxPainter,
                      onChanged: (newValue) {
                        setState(() {
                          checkboxPainter = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      activeColor: Colors.green,
                      title: Text("Plumber"),
                      value: checkboxPlumber,
                      onChanged: (newValue) {
                        setState(() {
                          checkboxPlumber = newValue!;
                        });
                        if (checkboxPlumber == false) {
                          setState(() {
                            checkboxPlumberFitting = false;
                            checkboxPlumberRepairing = false;
                          });
                        }
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    Visibility(
                      visible: checkboxPlumber == true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: FadeIn(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          child: CheckboxListTile(
                            activeColor: Colors.green,
                            title: Text("Full Fitting ",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                            value: checkboxPlumberFitting,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxPlumberFitting = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: checkboxPlumber == true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: FadeIn(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          child: CheckboxListTile(
                            activeColor: Colors.green,
                            title: Text("Repairing",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                            value: checkboxPlumberRepairing,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxPlumberRepairing = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                        ),
                      ),
                    ),
                    CheckboxListTile(
                      activeColor: Colors.green,
                      title: Text("Electrician"),
                      value: checkboxElectrician,
                      onChanged: (newValue) {
                        setState(() {
                          checkboxElectrician = newValue!;
                        });
                        if (checkboxElectrician == false) {
                          setState(() {
                            checkboxElectricianFitting = false;
                            checkboxElectricianRepairing = false;
                          });
                        }
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    Visibility(
                      visible: checkboxElectrician == true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: FadeIn(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          child: CheckboxListTile(
                            activeColor: Colors.green,
                            title: Text("Full Fitting",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                            value: checkboxElectricianFitting,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxElectricianFitting = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: checkboxElectrician == true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: FadeIn(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          child: CheckboxListTile(
                            activeColor: Colors.green,
                            title: Text("Repairing",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                            value: checkboxElectricianRepairing,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxElectricianRepairing = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                        ),
                      ),
                    ),
                    CheckboxListTile(
                      activeColor: Colors.green,
                      title: Text("Other Fields"),
                      value: checkboxOther,
                      onChanged: (newValue) {
                        setState(() {
                          checkboxOther = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    Visibility(
                      visible: checkboxOther == true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 7),
                        child: Center(
                          child: FadeIn(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            child: Container(
                              height: 45,
                              child: SimpleAutoCompleteTextField(
                                key: key,
                                suggestions: typesOfWork,
                                decoration: InputDecoration(
                                  hintText: 'Types Of Work',
                                ),
                                clearOnSubmit: true,
                                textChanged: (text) => currentText = text,
                                textSubmitted: (text) => setState(() {
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
                      visible: checkboxOther == true,
                      child: Flexible(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 200),
                          child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: selectedWorkType.length,
                            itemBuilder: (itemBuilder, context) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 12),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text('Save Changes'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                          shadowColor: Colors.grey,
                          elevation: 5,
                        ),
                        onPressed: () async {
                          isLoading = true;
                          DataBaseServices _db = await DataBaseServices()
                              .storeWorkInterestInformation(
                                  checkboxResidential,
                                  checkboxCommercial,
                                  checkboxResidential,
                                  checkboxConstructionRepairing,
                                  checkboxInterior,
                                  checkboxPainter,
                                  checkboxPlumberFitting,
                                  checkboxPlumberRepairing,
                                  checkboxElectricianFitting,
                                  checkboxElectricianRepairing,
                                  selectedWorkType);
                          print('Pressed');
                          isLoading = false;
                        },
                      ),
                    )
                  ],
                ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Work Profile"),
      ),
    );
  }
}
