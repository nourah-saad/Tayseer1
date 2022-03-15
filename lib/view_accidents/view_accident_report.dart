import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tayseer2/view_accidents/view_accidents_widget.dart';
import 'package:intl/intl.dart';

class AccidentReportWidget extends StatefulWidget {
  final id;
  const AccidentReportWidget({Key? key, this.id}) : super(key: key);

  @override
  _AccidentReportWidgetState createState() => _AccidentReportWidgetState();
}

class _AccidentReportWidgetState extends State<AccidentReportWidget> {
  @override
  void initState() {
    fetchdata();

    super.initState();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic address = '',
      adate = '',
      atime = '',
      time = '',
      status = '',
      driver1 = '',
      car1 = '',
      id1 = '',
      falut1 = '',
      driver2 = '',
      car2 = '',
      id2 = '',
      falut2 = '',
      accident_type = '';
  GeoPoint? location;
  final Accidents = FirebaseFirestore.instance.collection('Accident');
  void GetAddressFromLatLong(LatLng l) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(l.latitude, l.longitude);
    // print(placemarks);
    Placemark place = placemarks[0];
    setState(() {
      address = '${place.street} ${place.subLocality}, ${place.locality}';
    });
    print('the adrres is ${address}');
  }

  Future<void> fetchdata() async {
    var docSnapshot = await Accidents.doc(widget.id).get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();

      setState(() {
        //accident info

        location = data!['Location'];
        time = data['Date_time'].toDate();
        status = data['status'].toString();
        falut1 = data['Fault_assessment'][0].toString();
        falut2 = data['Fault_assessment'][1].toString();
        accident_type = data['accident_type'].toString();
        car1 = data['Cars_Involved'][0]['Car_plateNo'].toString();
        car2 = data['Cars_Involved'][1]['Car_plateNo'].toString();
        driver1 = data['Drivers_Involved'][0]['name'].toString();
        id1 = data['Drivers_Involved'][0]['Driver_Id'].toString();
        driver2 = data['Drivers_Involved'][1]['name'].toString();
        id2 = data['Drivers_Involved'][1]['Driver_Id'].toString();
      });
      print("-------------------------${falut1}-----------------------");
    }

    setState(() {
      adate = DateFormat('yyyy-MM-dd').format(time!);
      atime = DateFormat.Hms().format(time!);
    });

    GetAddressFromLatLong(LatLng(location!.latitude, location!.longitude));
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
              child: SingleChildScrollView(
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
                            'الطرف الأول',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
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
                            '${driver1} ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '  :الإسم',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${car1}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '  :رقم اللوحة',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${id1} ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '  :رقم الهوية/الإقامة',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${falut1}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '   :نسبة الخطأ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'الطرف الثاني',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '   ${driver2} ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '   :الإسم',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${car2}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '  :رقم اللوحة',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${id2} ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '  :رقم الهوية/الإقامة',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${falut2}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '   :نسبة الخطأ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              'الموقع: ${address}',
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF46494D),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${adate}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '  :التاريخ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${atime}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            ' :الوقت',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${status}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '  : حالة التقرير',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '  :تخطيط الحادث',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: accident_type == 'S1'
                              ? AssetImage('lib/images/accident1.png')
                              : AssetImage('lib/images/accident2.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 60, 0, 0),
            child: IconButton(
              icon: new Icon(
                Icons.chevron_left,
                size: 50,
              ),
              color: Color(0xFF46494D),
              //size: 50,
              onPressed: () async => Navigator.pop(context),
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
                      'تقرير الحادث',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF46494D),
                        fontFamily: 'Poppins',
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
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
