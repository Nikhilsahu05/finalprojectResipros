import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future sendWhatsAppNotification(
      bool whatsappNotification, String phoneNumber) async {
    await firebaseFirestore
        .collection("WhatsappNotifications")
        .doc(phoneNumber)
        .set({
      "send_WhatsApp_Updates": whatsappNotification,
    }).catchError((onError) {
      print('sendWhatsAppNotification ==> Error Data Updated ==> $onError');
    });
  }
}
