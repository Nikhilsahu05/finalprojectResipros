import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class InterestFieldScreen extends StatefulWidget {
  const InterestFieldScreen({Key? key}) : super(key: key);

  @override
  _InterestFieldScreenState createState() => _InterestFieldScreenState();
}

class _InterestFieldScreenState extends State<InterestFieldScreen> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
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

  var checkboxFitting = false;

  var checkboxPlumberRepairing = false;

  var checkboxElectricianRepairing = false;

  var checkboxElectricianFitting = false;

  List<String> typesOfWork = [];

  List selectedWorkType = [];

  bool isloadingDialog = false;

  TextEditingController _otherWorkField = TextEditingController();

  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    String currentText = "";
    return Scaffold(
      body: Column(
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
            title: Text("Construction & Repairing", style: TextStyle()),
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
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: Visibility(
              visible: checkboxConstruction,
              child: FadeIn(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: CheckboxListTile(
                  title: Text("Building ",
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
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
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              ),
            ),
          ),
          Visibility(
            visible: checkboxBuilding == true && checkboxConstruction == true,
            child: Padding(
              padding: const EdgeInsets.only(left: 100),
              child: FadeIn(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: CheckboxListTile(
                  title: Text("Residential",
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  value: checkboxResidential,
                  onChanged: (newValue) {
                    setState(() {
                      checkboxResidential = newValue!;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              ),
            ),
          ),
          Visibility(
            visible: checkboxBuilding == true && checkboxConstruction == true,
            child: Padding(
              padding: const EdgeInsets.only(left: 100),
              child: FadeIn(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: CheckboxListTile(
                  title: Text("Commercial",
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  value: checkboxCommercial,
                  onChanged: (newValue) {
                    setState(() {
                      checkboxCommercial = newValue!;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
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
                  title: Text("Repairing ",
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  value: checkboxConstructionRepairing,
                  onChanged: (newValue) {
                    setState(() {
                      checkboxConstructionRepairing = newValue!;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              ),
            ),
          ),
          CheckboxListTile(
            title: Text("Interior Designer"),
            value: checkboxInterior,
            onChanged: (newValue) {
              setState(() {
                checkboxInterior = newValue!;
              });
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text("Painter"),
            value: checkboxPainter,
            onChanged: (newValue) {
              setState(() {
                checkboxPainter = newValue!;
              });
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          CheckboxListTile(
            title: Text("Plumber"),
            value: checkboxPlumber,
            onChanged: (newValue) {
              setState(() {
                checkboxPlumber = newValue!;
              });
              if (checkboxPlumber == false) {
                setState(() {
                  checkboxFitting = false;
                  checkboxPlumberRepairing = false;
                });
              }
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          Visibility(
            visible: checkboxPlumber == true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: FadeIn(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: CheckboxListTile(
                  title: Text("Full Fitting ",
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  value: checkboxFitting,
                  onChanged: (newValue) {
                    setState(() {
                      checkboxFitting = newValue!;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
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
                  title: Text("Repairing",
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  value: checkboxPlumberRepairing,
                  onChanged: (newValue) {
                    setState(() {
                      checkboxPlumberRepairing = newValue!;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              ),
            ),
          ),
          CheckboxListTile(
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
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          Visibility(
            visible: checkboxElectrician == true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: FadeIn(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: CheckboxListTile(
                  title: Text("Full Fitting",
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  value: checkboxElectricianFitting,
                  onChanged: (newValue) {
                    setState(() {
                      checkboxElectricianFitting = newValue!;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
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
                  title: Text("Repairing",
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  value: checkboxElectricianRepairing,
                  onChanged: (newValue) {
                    setState(() {
                      checkboxElectricianRepairing = newValue!;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              ),
            ),
          ),
          CheckboxListTile(
            title: Text("Other Fields"),
            value: checkboxOther,
            onChanged: (newValue) {
              setState(() {
                checkboxOther = newValue!;
              });
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          Visibility(
            visible: checkboxOther == true,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Container(
                  height: 45,
                  child: Flexible(
                    child: TextField(
                      controller: _otherWorkField,
                      onSubmitted: (value) {
                        _otherWorkField.text = value;
                        setState(() {
                          selectedWorkType.add(_otherWorkField.text);
                          selectedWorkType.reversed;
                        });
                        _otherWorkField.clear();
                      },
                      decoration: InputDecoration(
                          hintMaxLines: 3,
                          labelText: 'Other Field',
                          labelStyle: TextStyle(fontSize: 13),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.blue),
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
            child: Center(
              child: Container(
                height: 45,
                child: SimpleAutoCompleteTextField(
                  key: key,
                  suggestions: [
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
                  ],
                  decoration: InputDecoration(
                    hintText: 'Types Of Work',
                  ),
                  clearOnSubmit: true,
                  textChanged: (text) => currentText = text,
                  textSubmitted: (text) => setState(() {
                    if (text != "") {
                      selectedWorkType.add(text);
                    }
                  }),
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: ListView.builder(
                controller: _controller,
                scrollDirection: Axis.vertical,
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
                                selectedWorkType.removeAt(context);
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
                                    borderRadius: BorderRadius.circular(100.0),
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
                                    backgroundColor: Colors.orange.shade600,
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
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Work Profile"),
      ),
    );
  }
}
