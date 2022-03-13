import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tayseer2/notification/notification.dart';
import 'package:vector_math/vector_math.dart' as math;

import '../Driver/Driver.dart';
import '../FlutterFlow/FlutterFlowTheme.dart';
import '../FlutterFlow/FlutterFlowWidgets.dart';
import 'package:flutter/material.dart';

import 'DriverDetails.dart';

class SelectCarInvolvedCarsPageWidget extends StatefulWidget {
  const SelectCarInvolvedCarsPageWidget(
      {Key? key,
      required this.accTime,
      required this.accID,
      required this.accLocation})
      : super(key: key);
  final DateTime accTime;
  final String accID;
  final Position accLocation;

  @override
  _SelectCarInvolvedCarsPageWidgetState createState() =>
      _SelectCarInvolvedCarsPageWidgetState();
}

class _SelectCarInvolvedCarsPageWidgetState
    extends State<SelectCarInvolvedCarsPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Driver> involvedDrivers = [];
  List<String> involvedDriversIDs = [];

  @override
  void initState() {
    involvedDrivers.clear();
    getCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF85BBC2),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 130, 0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: Color(0xFFD8EBEE),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView.builder(
                itemCount: involvedDrivers.length,
                itemBuilder: (context, index) {
                  return DriverDetails(
                    accID: widget.accID,
                    inDriverName: involvedDrivers[index].driverName,
                    inDriverID: involvedDrivers[index].driverID,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(80, 530, 0, 0),
            child: FFButtonWidget(
              onPressed: () {
                print('Button pressed ...');
              },
              text: 'إضافة سيارة اخرى',
              options: FFButtonOptions(
                width: 200,
                height: 50,
                color: Color(0xFF85BBC2),
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 25,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 60, 0, 0),
            child: Icon(
              Icons.chevron_left,
              color: Color(0xFF46494D),
              size: 50,
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, -0.82),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Text(
                    'حدد السيارة المشاركة في الحادث',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.title1.override(
                      fontFamily: 'Poppins',
                      color: Color(0xFF46494D),
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getCars() async {
    int earthRadius = 6371;
    double lowestLat = widget.accLocation.latitude /*24.7455293*/ -
        math.degrees(5 / earthRadius);
    //  (0.008 * 0.621371192); 1km in deg * 1km distance

    double greatestLat = widget.accLocation.latitude /*24.7455293*/ +
        math.degrees(5 / earthRadius);
    // (0.008 * 0.621371192); // 1km in deg * 1km distance

    double lowestLong = widget.accLocation.longitude /*46.6551531*/ + // -
        math.degrees(asin(5 / earthRadius) /
            cos(math.degrees(widget.accLocation.latitude /*24.7455293*/)));
    // (0.008 * 0.621371192); // 1km in deg * 1km distance

    double greatestLong = widget.accLocation.longitude /*46.6551531*/ - //+
        math.degrees(asin(5 / earthRadius) /
            cos(math.degrees(widget.accLocation.latitude /*24.7455293*/)));
    //  (0.008 * 0.621371192); // 1km in deg * 1km distance

    print(
        'low lat $lowestLat, great lat $greatestLat, low lon $lowestLong, great long $greatestLong');

    DateTime lowestTime = widget.accTime.subtract(new Duration(minutes: 10));
    print('low date $lowestTime');

    DateTime greatTime = widget.accTime.add(new Duration(minutes: 10));
    print('great date $greatTime');
    await FirebaseFirestore.instance
        .collection('Tracking')
        .where(FieldPath.documentId, isNotEqualTo: user.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        await element.reference
            .collection('locations')
            .where('lat', isGreaterThan: lowestLat)
            .where('lat', isLessThanOrEqualTo: greatestLat)
            .get()
            .then((value) {
          print('lengthy ${value.size}');
          value.docs.forEach((doc) {
            if (lowestLong <= doc.data()['long'] &&
                greatestLong >= doc.data()['long']) {
              if (((doc.data()['time'] as Timestamp).toDate())
                      .isAfter(lowestTime) &&
                  ((doc.data()['time'] as Timestamp).toDate())
                      .isBefore(greatTime) &&
                  !involvedDriversIDs.contains(element.reference.id)) {
                print('found user ${doc.reference.parent} ');
                setState(() {
                  involvedDriversIDs.add('${element.reference.id}');
                  involvedDrivers.add(Driver(
                      driverID: element.reference.id,
                      driverName: element.data()['name']));
                  print('driver name ${element.reference.id}');
                  print('dr name: ${element.data()['name']}');
                });
              }
            }
          });
        });
      });
    });
  }
}
