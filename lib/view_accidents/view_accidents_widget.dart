import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geocoding/geocoding.dart';
//import 'package:tayseer/home_page/home_page_widget.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:tayseer2/view_accidents/view_accident_report.dart';

import '../global/global.dart';
import '../mainScreen/main_screen.dart';
import 'Search_Bar.dart';

class ViewAccidentsWidget extends StatefulWidget {
  String? address;
   ViewAccidentsWidget({Key? key,this.address}) : super(key: key);

  @override
  _ViewAccidentsWidgetState createState() => _ViewAccidentsWidgetState();
}

class _ViewAccidentsWidgetState extends State<ViewAccidentsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> accidents = [];
  List? newDataList;
  GeoPoint? location;
  DateTime? time;
  List<Map<String, dynamic>> _foundlocacation = [];

  var id;
  var Accid = '';
  var dataaa = ' ';
  var Address = '';
  final Future<FirebaseApp> _future = Firebase.initializeApp();

  @override
  void initState() {
    accidents.clear();
    addtolist();



   // onItemChanged('imam');
   // final data=  newDataList![0]['location'];
    //print('data $data');
    super.initState();

  }
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];

      results = accidents
          .where((user) =>
          user["location"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
 //   }

    // Refresh the UI
    setState(() {
      _foundlocacation = results;
    });
  }
  void addtolist() async {
    int count = 0;

    var value;

    var exists = await FirebaseFirestore.instance
        .collection('Accident')
        .orderBy('Date_time')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) async {
        var driver1docid, driver2docid;

        var currentFirebaseUser = fAuth.currentUser!.uid;
        setState(() {
          location = element.data()['Location'];
          time = element.data()['Date_time'].toDate();
          driver1docid = element.data()['Drivers_Involved'][0]['uid'];
          driver2docid = element.data()['Drivers_Involved'][1]['uid'];
          id = element.id.toString();
        });
        String dtime = DateFormat('yyyy-MM-dd').format(time!);
        String ddtime = DateFormat.Hms().format(time!);

         List<Placemark> placemarks = await placemarkFromCoordinates(location!.latitude, location!.longitude);
        Placemark place = placemarks[0];

        setState(() {
          Address = '${place.street}, ${place.locality}, ${place.country}';
        });
         print('the adrres is mymyjh ${Address}');
        var value = {
          'location': '${Address}',
          'date': '${dtime.toString()}',
          'time': '${ddtime.toString()}',
          'id': '${id}',
        };
print(value);
        //add only the current user reports
        if (driver2docid == currentFirebaseUser ||
            driver1docid == currentFirebaseUser)
          accidents.insert(count++, value);
        _foundlocacation = accidents ;
        _runFilter('Saudi Arabia');
    // final data=   newDataList![0]['location'];
    // print('current data$data');

      });
    });
  }

  // onItemChanged(String value) {
  //   setState(() {
  //
  //     // newDataList!.forEach((u) {
  //     //   if(accidents.contains(u["address"])) selectedUsers.add(u);
  //     // });
  //     newDataList = accidents
  //         .where((string) => string.toLowerCase().contains(value[0]))
  //         .toList();
  //   });
  // }
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
              child: accidentChild(_foundlocacation, this.context),
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
              onPressed: () async => await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ),
                (r) => false,
              ),
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
                    'البلاغات السابقة',
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


          Container(

              width: MediaQuery.of(context).size.width,
              padding: EdgeInsetsDirectional.fromSTEB(10, 140, 10, 10),
              child:InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Search_bar()),
                  );
                },
              child:Card(
                child:Padding(
    padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                  Container(child: Text(widget.address==null?'Search .......':widget.address!),),
                  Container(child:InkWell(onTap: (){

                  },child: Icon(
                    Icons.search,

                    size: 30.0,
                  ),)),
                ],),
              )
          ))),
        ],
      ),
    );
  }
}

Widget accidentChild(data, context) {

  return ListView(
    children: [
      for (var i = 0; i < data.length; i++)
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 2),
              child: Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFF85BBC2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  //  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 7, 10, 0),
                                child: Text(
                                '${data[i]['location']}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 7, 10, 0),
                              child: Text(
                                ': الموقع ',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 7, 10, 0),
                                child: Text(
                                  '${data[i]['date']}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 7, 10, 0),
                              child: Text(
                                ': التاريخ ',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  SizedBox(
                                    width: 17,
                                  )
                                ]),
                                Row(children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      onPrimary: Colors.black87,
                                      primary: Color(0xFF92D9E3),
                                      fixedSize: Size(129, 20),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (c) =>
                                                  AccidentReportWidget(
                                                      id: '${data[i]['id']}')));
                                    },
                                    child: Text(
                                      'عرض التقرير',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                      ),
                                    ),
                                  )
                                ]),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 7, 10, 0),
                                child: Text(
                                  '${data[i]['time']}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 7, 10, 0),
                              child: Text(
                                ': الوقت ',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    ],
  );
}
