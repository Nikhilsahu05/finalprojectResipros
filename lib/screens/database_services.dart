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
    bool constructionandRepairing,
    bool building,
    bool commercialBuilding,
    bool residentialBuilding,
    bool constructionRepairing,
    bool interiorDesigner,
    bool painter,
    bool plumber,
    bool plumberFitting,
    bool plumberRepairing,
    bool elctrician,
    bool electricianFitting,
    bool electricianRepairing,
    List OtherFields,
  ) async {
    await _firebaseFirestore
        .collection(_auth.currentUser!.uid)
        .doc(dbDocWorkInterestInformation)
        .set({
      "constructionAndRepairing": constructionandRepairing,
      "building": building,
      "commercialBuilding": commercialBuilding,
      "residentialBuilding": residentialBuilding,
      "constructionRepairing": constructionRepairing,
      "interiorDesigning": interiorDesigner,
      "painter": painter,
      'plumber': plumber,
      'plumberFitting': plumberFitting,
      'plumberRepairing': plumberRepairing,
      "electrician": elctrician,
      "electricianFitting": electricianFitting,
      "electricianRepairing": electricianRepairing,
      "otherField": OtherFields,
    }).whenComplete(() {
      print("Database services + storePhoneNumberInformation ====> COMPLETED");
    }).catchError((onError) {
      print("Database services + storePhoneNumberInformation ====> $onError");
    });
  }
}
