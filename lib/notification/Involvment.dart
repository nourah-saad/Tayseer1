import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'initialization.dart';

String? userEmail = FirebaseAuth.instance.currentUser!.email;
monitorInvolvment() {
  FirebaseFirestore.instance
      .collection('Accident')
      .where('InvolvedEmail', isEqualTo: '$userEmail')
      .where('status', isEqualTo: 'sent')
      .snapshots()
      .listen((value) {
    print('${value.docs.length} herel');
    value.docs.forEach((element) {
      showNotification(
          status: 'ques',
          driverName: element.data()['DriverName'],
          involvedName: element.data()['involvedName'],
          payload: element.data()['AccID']);
      element.reference.update({'status': 'recieved'});
    });
  });
  FirebaseFirestore.instance
      .collection('Accident')
      .where('status', isEqualTo: 'jAccepted')
      .where('DriverEmail', isEqualTo: userEmail)
      .snapshots()
      .listen((value) {
    print('${value.docs.length} here2l');
    value.docs.forEach((element) {
      showNotification(
          status: 'القبول',
          driverName: element.data()['DriverName'],
          involvedName: element.data()['involvedName'],
          payload: element.data()['AccID']);
      element.reference.update({'status': 'مقبول'});
    });
  });

  FirebaseFirestore.instance
      .collection('Accident')
      .where('status', isEqualTo: 'jRejected')
      .where('DriverEmail', isEqualTo: userEmail)
      .snapshots()
      .listen((value) {
    print('${value.docs.length} herel');
    value.docs.forEach((element) {
      showNotification(
          status: 'الرفض',
          driverName: element.data()['DriverName'],
          involvedName: element.data()['involvedName'],
          payload: element.data()['AccID']);
      element.reference.update({'status': 'مرفوض'});
    });
  });
}
