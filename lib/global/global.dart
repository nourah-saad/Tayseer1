import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tayseer2/models/driver_model.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
DriverModel? driverModelCurrentInfo;
StreamSubscription<Position>? streamSubscriptionPosition;
