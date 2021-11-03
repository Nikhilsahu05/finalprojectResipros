import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';

class InterestFieldScreen extends StatefulWidget {
  const InterestFieldScreen({Key? key}) : super(key: key);

  @override
  _InterestFieldScreenState createState() => _InterestFieldScreenState();
}

class _InterestFieldScreenState extends State<InterestFieldScreen> {
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

  List typesOfWork = [
    'Carpentry',
    'Plasterwork',
    'Steel construction work',
    "Sheet metal work",
    "Glass work",
    "Coating work",
    "Waterproofing work",
    "Thermal insulation work",
    "Telecommunications work",
    "Landscape gardening",
    "Firefighting facilities work",
    "Waste facilities work",
    "Water facilities work",
  ];

  List selectedWorkType = [];

  bool isloadingDialog = false;

  void _openFilterDialog() async {
    await FilterListDialog.display<dynamic>(context,
        listData: typesOfWork,
        selectedListData: selectedWorkType,
        height: 480,
        headlineText: "Select Type Of Work",
        searchFieldHintText: "Search Here", choiceChipLabel: (item) {
      return item;
    }, validateSelectedItem: (list, val) {
      return list!.contains(val);
    }, onItemSearch: (list, text) {
      if (list!.any(
          (element) => element.toLowerCase().contains(text.toLowerCase()))) {
        return list!
            .where(
                (element) => element.toLowerCase().contains(text.toLowerCase()))
            .toList();
      } else {
        return [];
      }
    }, onApplyButtonClick: (list) {
      if (list != null) {
        setState(() {
          selectedWorkType = List.from(list);
        });

        print(selectedWorkType);
        Get.back();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
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
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
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
                    title: Text("Repairing ",
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
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
                    title: Text("Repairing",
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
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
                    title: Text("Repairing",
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
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
              title: Text("Other Fields"),
              value: checkboxOther,
              onChanged: (newValue) {
                setState(() {
                  checkboxOther = newValue!;
                });
                if (checkboxOther == true) {
                  _openFilterDialog();
                }
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: () {},
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 5.0,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 10.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Text(
                              '${selectedWorkType[0]}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
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
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Work Profile"),
      ),
    );
  }
}
