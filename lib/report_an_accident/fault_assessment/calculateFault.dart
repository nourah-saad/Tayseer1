import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tayseer2/navigationService.dart';
import 'package:tayseer2/view_accidents/view_accident_report.dart';

proccessAcc({required accID, required driverID, required involvedID}) async {
  String accType = '';
  DateTime accTime = await getTime(accID);
  print('heeerrre timmmy');
  List<double> driverlocations = await getLocation(driverID, accTime);
  print('size is ${driverlocations.length}');
  for (int i = 0; i < driverlocations.length; i++) {
    print(
        'location $i in driverlocations of $driverID is ${driverlocations[i]}');
  }
  List<double> involvedLocations = await getLocation(involvedID, accTime);
  for (int i = 0; i < involvedLocations.length; i++) {
    print('location $i in involvedLocations is ${involvedLocations[i]}');
  }

  String driverBehavior = getBehavior(driverlocations);
  print('driver behavior is $driverBehavior');
  String involvedBehavior = getBehavior(involvedLocations);
  print('indriver behavior is $involvedBehavior');
  String guilty = '';

  if (driverBehavior == 'Circle') {
    guilty = driverID;
    accType = 'drift';
  } else if (involvedBehavior == 'Circle') {
    involvedID;
    accType = 'drift';
  } else if (involvedBehavior == driverBehavior) {
    switch (driverBehavior) {
      case 'StraightF':
      case 'StraightB':
        accType = 'S1';
        if (driverlocations[0] < involvedLocations[0]) {
          guilty = driverID;
        } else {
          guilty = involvedID;
        }
        break;
      /*case 'StraightB':
        if (driverlocations[0] > involvedLocations[0]) {
          guilty = driverID;
        } else {
          guilty = involvedID;
        }
        break;*/
    }
  }
  print('guilty driver is $guilty');

  await FirebaseFirestore.instance.collection('Accident').doc(accID).update({
    'Fault_assessment': FieldValue.arrayUnion([
      guilty == driverID ? '%100' : '%0',
      guilty == involvedID ? '%100' : '%0',
    ]),
    'accident_type': accType,
  });

  Navigator.pushReplacement(
      navigationService.navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => AccidentReportWidget(
                id: accID,
              ) /*AccidentReportWidget(accID: accID)*/));
}

String getBehavior(List<double> driverlocations) {
  int countF = 0, countB = 0;

  for (int i = 0; i < driverlocations.length - 1; i++) {
    if (driverlocations[i] <= driverlocations[i + 1])
      countF++;
    else
      countB++;
  }
  if (countF == driverlocations.length - 1) {
    return 'StraightF';
  } else if (countB == driverlocations.length - 1) {
    return "StraightB";
  } else {
    return "Circle";
  }
}

getTime(accID) async {
  DateTime time = await FirebaseFirestore.instance
      .collection('Accident')
      .doc(accID)
      .get()
      .then((value) => (value.data()!['Date_time'] as Timestamp).toDate());

  return time;
}

getLocation(String driverID, DateTime accTime) async {
  List<double> locations = [];
  for (int i = 10; i > 0; i--) {
    DateTime time = accTime.subtract(Duration(seconds: i));
    print('time fault $time');
    await FirebaseFirestore.instance
        .collection('Tracking')
        .doc(driverID)
        .collection('locations')
        .where('time', isGreaterThanOrEqualTo: time)
        .where('time', isLessThanOrEqualTo: accTime)
        .limit(1)
        .get()
        .then((value) {
      print('we found ${value.docs.length}');
      value.docs.forEach((element) {
        locations.add(element.data()['lat']);
      });
    });
  }
  return locations;
}
