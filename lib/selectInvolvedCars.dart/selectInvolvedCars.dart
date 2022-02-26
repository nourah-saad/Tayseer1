import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:tayseer2/Tracking/Tracking.dart';
import 'package:tayseer2/notification/notification.dart';

import '../FlutterFlow/FlutterFlowTheme.dart';
import '../FlutterFlow/FlutterFlowWidgets.dart';
import 'package:flutter/material.dart';

class SelectCarInvolvedCarsPageWidget extends StatefulWidget {
  const SelectCarInvolvedCarsPageWidget({Key? key, required this.accTime})
      : super(key: key);
  final DateTime accTime;

  @override
  _SelectCarInvolvedCarsPageWidgetState createState() =>
      _SelectCarInvolvedCarsPageWidgetState();
}

class _SelectCarInvolvedCarsPageWidgetState
    extends State<SelectCarInvolvedCarsPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: Container(
                      width: 300,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Color(0xFF85BBC2),
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 130, 0, 0),
                                child: Text(
                                  '||||||',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        60, 130, 0, 0),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        print('Button pressed ...');
                                      },
                                      text: 'اختيار',
                                      options: FFButtonOptions(
                                        width: 130,
                                        height: 40,
                                        color: Color(0xFF92D9E3),
                                        textStyle:
                                            FlutterFlowTheme.title1.override(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Text(
                                  'نوع السيارة:',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: Text(
                                  'لون السيارة:',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: Text(
                                  'رقم اللوحة:',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
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
                ],
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
    print('entered');
    Position curentLocation = await Geolocator.getCurrentPosition();
    print('currenty $curentLocation');
    double lowestLat = curentLocation.latitude -
        (0.008 * 0.621371192); // 1km in deg * 1km distance
    double lowestLong = curentLocation.longitude -
        (0.008 * 0.621371192); // 1km in deg * 1km distance

    double greatestLat = curentLocation.latitude +
        (0.008 * 0.621371192); // 1km in deg * 1km distance
    double greatestLong = curentLocation.longitude +
        (0.008 * 0.621371192); // 1km in deg * 1km distance

    print(
        'low lat $lowestLat, low lon $lowestLong,  great lat $greatestLat, great long $greatestLong');

    DateTime lowestTime = widget.accTime.subtract(new Duration(minutes: 10));
    print('low date $lowestTime');

    DateTime greatTime = widget.accTime.add(new Duration(minutes: 10));
    print('great date $greatTime');

    await FirebaseFirestore.instance
        .collection('Tracking')
        .where(FieldPath.documentId, isNotEqualTo: user.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference
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
                      .isBefore(greatTime))
                print('found user ${doc.reference.parent} ');
            }
          });
        }); // not this user
      });
    });
  }
}
