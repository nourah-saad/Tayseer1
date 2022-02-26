import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tayseer2/notification/notification.dart';

import '../Driver/getName.dart';

List<LocationClass> list = [];
Location location = new Location();
late bool _serviceEnabled;
late LocationData _locationData;

requestPermission() async {
  _serviceEnabled = await location.serviceEnabled();
  while (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
  }
  if (location.hasPermission() == false) {
    await location.requestPermission();
  }
  while (!await Permission.locationAlways.isGranted)
    await Permission.locationAlways.request();
  location.enableBackgroundMode(enable: true);

  await location.changeSettings(
      accuracy: LocationAccuracy.navigation, distanceFilter: 3
      //if 10 seconds are passed AND* if the phone is moved at least 5 meters, give the location. must be (both)
      );
  getcurrentLocation();
}

getcurrentLocation() async {
  location.onLocationChanged.listen((LocationData currentLocation) async {
    FirebaseFirestore.instance
        .collection('Tracking')
        .doc('${FirebaseAuth.instance.currentUser!.uid}')
        .set({
      'email': '${FirebaseAuth.instance.currentUser!.email}',
      'name': await getName(user.uid)
    });
    FirebaseFirestore.instance
        .collection('Tracking')
        .doc('${FirebaseAuth.instance.currentUser!.uid}')
        .collection('locations')
        .doc(
            '${DateTime.fromMillisecondsSinceEpoch((currentLocation.time)!.toInt())}')
        .set({
      'location':
          GeoPoint(currentLocation.latitude!, currentLocation.longitude!),
      'time':
          DateTime.fromMillisecondsSinceEpoch((currentLocation.time)!.toInt()),
      'speed': currentLocation.speed,
      'lat': currentLocation.latitude,
      'long': currentLocation.longitude
    });
  });
}

class LocationClass {
  final lat;
  final long;
  final time;
  final speed;

  LocationClass(
      {required this.lat,
      required this.long,
      required this.time,
      required this.speed});
}
