import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:resipros/constants/constants.dart';

class DataBaseServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String? uid;

  Future storeProfileInformation(
      String profileImage,
      TextEditingController _fullNameTextController,
      TextEditingController _fullAddressController,
      TextEditingController _pinCodeTextController,
      String? _selected,
      String state,
      String district) async {
    await _firebaseFirestore
        .collection(_auth.currentUser!.uid)
        .doc(dbDocProfileInformation)
        .set({
      "profileImageURL": profileImage,
      "fullName": _fullNameTextController.text,
      "fullAddress": _fullAddressController.text,
      "pinCode": _pinCodeTextController.text,
      "locality": _selected,
      "state": state,
      "district": district,
    }).whenComplete(() {
      print("Database services + storeProfileInformation ====> COMPLETED");
    }).catchError((onError) {
      print("Database services + storeProfileInformation ====> $onError");
    });
  }

  Future storePhoneNumberInformation(
    String? phoneNumber,
  ) async {
    await _firebaseFirestore
        .collection(_auth.currentUser!.uid)
        .doc(dbDocPhoneNumberInformation)
        .set({"phoneNumber": phoneNumber}).whenComplete(() {
      print("Database services + storePhoneNumberInformation ====> COMPLETED");
    }).catchError((onError) {
      print("Database services + storePhoneNumberInformation ====> $onError");
    });
  }

  Future storeRefferalCode(
    String refferalCode,
  ) async {
    await _firebaseFirestore
        .collection(_auth.currentUser!.uid)
        .doc(dbDocRefferalInformation)
        .set({"refferalCode": refferalCode}).whenComplete(() {
      print("Database services + storePhoneNumberInformation ====> COMPLETED");
    }).catchError((onError) {
      print("Database services + storePhoneNumberInformation ====> $onError");
    });
  }

  Future storeWorkInterestInformation(
    bool residential,
    bool commercial,
    bool repairing,
    bool repairingConstruction,
    bool interiorDesigner,
    bool painter,
    bool fullFittingPlumber,
    bool repairingPlumber,
    bool fullFittingElectrician,
    bool repairingElectrician,
    List otherFieldsList,
  ) async {
    await _firebaseFirestore
        .collection(_auth.currentUser!.uid)
        .doc(dbDocWorkInterestInformation)
        .set({
      "ConstructionAndRepairing": [
        {
          "Building": [
            {
              "Residential": residential,
              "Commercial": commercial,
            }
          ]
        },
        {
          "Repairing": repairingConstruction,
        }
      ],
      "InteriorDesigner ": interiorDesigner,
      "Painter ": painter,
      "Plumber ": [
        {
          'FullFitting': fullFittingPlumber,
          'Repairing': repairingPlumber,
        }
      ],
      "Electrician ": [
        {
          'FullFitting': fullFittingElectrician,
          'Repairing': repairingElectrician,
        }
      ],
      'OtherFields': otherFieldsList,
    }).whenComplete(() {
      print("Database services + storePhoneNumberInformation ====> COMPLETED");
    }).catchError((onError) {
      print("Database services + storePhoneNumberInformation ====> $onError");
    });
  }
}
