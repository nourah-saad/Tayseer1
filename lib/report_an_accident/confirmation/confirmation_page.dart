import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tayseer2/notification/notification.dart';
import 'package:tayseer2/tapPages/home.dart';
import '../../FlutterFlow/FlutterFlowTheme.dart';
import '../../FlutterFlow/FlutterFlowWidgets.dart';
import 'package:flutter/material.dart';

class ConfirmationPageWidget extends StatefulWidget {
  ConfirmationPageWidget(
      {Key? key, required this.accidentID, required this.sender})
      : super(key: key);
  final String accidentID;

  String driverName = "";
  String driverPlate = '';
  String driverCar = '';
  String driverCarColor = '';
  String accidentLocation = '';
  String sender;

  @override
  _ConfirmationPageWidgetState createState() => _ConfirmationPageWidgetState();
}

class _ConfirmationPageWidgetState extends State<ConfirmationPageWidget> {
  @override
  void initState() {
    getDetails();
    super.initState();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color.fromARGB(255, 70, 100, 104),
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 40, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          ' اسم المبلغ: ${widget.driverName}',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'رقم اللوحة: ${widget.driverPlate}',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'نوع السيارة: ${widget.driverCar}',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'لون السيارة: ${widget.driverCarColor}',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    //mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
                        child: Flexible(
                          child: Text(
                            'موقع الحادث: ${widget.accidentLocation}',
                            overflow: TextOverflow.visible,
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
                                  Navigator.pop(context);
                                  update('مرفوض');
                                  SnackBar snackbar = SnackBar(
                                      content: Text('تم الرفض بنجاح',
                                          textAlign: TextAlign.center));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                  sendNotification(
                                    receiver: widget.sender,
                                    title: 'تأكيد الحادث',
                                    msg: 'تم الرفض من قبل الطرف الآخر بنجاح',
                                    accID: widget.accidentID,
                                    sender: '${user.uid}',
                                    type: 'denied',
                                  );
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                },
                                text: 'رفض',
                                options: FFButtonOptions(
                                  width: 130,
                                  height: 40,
                                  color: Color(0xFFEB6666),
                                  textStyle: FlutterFlowTheme.title1.override(
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
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
                                  Navigator.pop(context);
                                  update('مقبول');
                                  SnackBar snackbar = SnackBar(
                                      content: Text('تم التأكيد بنجاح',
                                          textAlign: TextAlign.center));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                  sendNotification(
                                    receiver: widget.sender,
                                    title: 'تأكيد الحادث',
                                    msg: 'تم التأكيد من قبل الطرف الآخر بنجاح',
                                    accID: widget.accidentID,
                                    sender: '${user.uid}',
                                    type: 'accept',
                                  );
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                },
                                text: 'تأكيد',
                                options: FFButtonOptions(
                                  width: 130,
                                  height: 40,
                                  color: Color(0xFF8BD784),
                                  textStyle: FlutterFlowTheme.title1.override(
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
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Text(
                      'تأكيد الحادث',
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
          ),
        ],
      ),
    );
  }

  update(String status) {
    FirebaseFirestore.instance
        .collection('Accident')
        .doc('${widget.accidentID}')
        .get()
        .then((value) => value.reference.update({'status': status}));
  }

  getDetails() async {
    print('acc id ${widget.accidentID}');
    await FirebaseFirestore.instance
        .collection('Accident')
        .doc('${widget.accidentID}')
        .get()
        .then((doc) {
      setState(() {
        widget.driverName = doc.data()!['Drivers_Involved'][0]['name'];
        widget.driverPlate = doc.data()!['Cars_Involved'][0]['Car_plateNo'];
        widget.driverCar = doc.data()!['Cars_Involved'][0]['Car_model'];
        widget.driverCarColor = doc.data()!['Cars_Involved'][0]['Car_color'];
        GeoPoint loc = (doc.data()!['Location'] as GeoPoint);
        getLocationName(loc);
        /**/
      });
    });
  }

  void getLocationName(GeoPoint loc) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(loc.latitude, loc.longitude);

    setState(() {
      widget.accidentLocation = '${placemarks[0].street!}';
    });
  }
}