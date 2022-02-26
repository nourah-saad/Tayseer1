import 'dart:async';
import 'dart:math' as Math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tayseer2/assistants/assistant_methods.dart';
import 'package:tayseer2/authintication/signup_screen.dart';
import 'package:tayseer2/infoHandler/app_info.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  double searchLocationContainerHeight = 220;

  Position? userCurrentPosition;

  //Position? ccPosition;

  var geoLocator = Geolocator();

  LocationPermission? _locationPermission;
  double bottomPaddingOfMap = 0;

  checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();

    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  locateUserPosition() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    userCurrentPosition = cPosition;
    // ccPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    LatLng latLngPosition =
        LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14); //zoom

    await newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String humanReadableAddress =
        await AssistantMethods.searchAddressForGeographicCoOrdinates(
            userCurrentPosition!, context);
    print("this is your address = " + humanReadableAddress);
  }

  @override
  void initState() {
    super.initState();

    checkIfLocationPermissionAllowed();
    locateUserPosition();
    getMarkerData();
  }

  // map to store all markers
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  // to store destinations
  List<Destination> destinationlist = [];

  // initialize the marker to every user
  initMarkerData(longitude, latitude, name, nationality, specifyId, dis) {
    var markerIdVal = specifyId;
    final markerId = MarkerId(markerIdVal.toString());
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(longitude, latitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(
        title: name,
        snippet: nationality + ' $dis Km',
      ),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  // initialize the reference
  final db = FirebaseDatabase.instance.reference().child('drivers');

  // select users longitude and latitude
  Future getMarkerData() async {
    markers.clear();

    await FirebaseDatabase.instance.ref('drivers').once().then((snapshot) {
      Map<dynamic, dynamic>? values = snapshot.snapshot.value as Map?;
      values!.forEach((key, values) {
        if (values['latitude'] != null && values['longitude'] != null) {
          // cPosition from the sign up page , I put it as global variable
          // to store the distance between me and other users
          double dis = getDist(cPosition.longitude, cPosition.latitude,
              values['latitude'], values['longitude']);

          // store data in object
          var dd = Destination(values['latitude'], values['latitude'],
              values['name'], values['did'].toString(), values['nationality'],
              distance: dis);

          // add the object in the list
          destinationlist.add(dd);

          // call the function to make marker
          //initMarkerData(values, values['did'],dis);

          if (kDebugMode) {
            print('*****************************');
            print(values['latitude']);

            print(dis);
          }
        }
      });

      int near = 0;
      destinationlist.forEach((element) {
        if (near < 5) {
          // call the function to make marker
          initMarkerData(
            element.lng,
            element.lat,
            element.name,
            element.nationality,
            element.Id.toString(),
            element.distance,
          );

          if (kDebugMode) {
            print('********************************');
            print(element.name + ' /// ' + element.distance.toString() + ' KM');
            print('near : $near');
          }
          setState(() {
            near++;
          });
        } else {
          if (kDebugMode) {
            print('********************************');
            print(element.name + ' /// ' + element.distance.toString() + ' KM');
            print('near is not within first 5 ');
          }
        }
      });
    });
  }

  // function to measure the distance between tow locations
  double getDist(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(
            startLatitude, startLongitude, endLatitude, endLongitude) /
        1000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              setState(() {
                bottomPaddingOfMap = 240;
              });
              locateUserPosition();
            },
            markers: Set<Marker>.of(markers.values),
          ),

          //ui for searching location
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSize(
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 120),
              child: Container(
                height: searchLocationContainerHeight,
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Column(
                    children: [
                      //from
                      Row(
                        children: [
                          const Icon(
                            Icons.add_location_alt_outlined,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "From",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              Text(
                                Provider.of<AppInfo>(context)
                                            .userPickUpLocation !=
                                        null
                                    ? (Provider.of<AppInfo>(context)
                                                .userPickUpLocation!
                                                .locationName!)
                                            .substring(0,
                                                44) + //عدد الاحرف اللي تطلع في الخريطة
                                        "..."
                                    : "not getting address",
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 10.0),

                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey,
                      ),

                      const SizedBox(height: 16.0),

                      const SizedBox(height: 16.0),

                      ElevatedButton(
                        child: const Text(
                          "التالي",
                        ),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF85BBC2),
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Destination {
  double lat;
  double lng;
  String name;
  String Id;
  String nationality;
  double distance;

  Destination(this.lat, this.lng, this.name, this.Id, this.nationality,
      {required this.distance});
}
