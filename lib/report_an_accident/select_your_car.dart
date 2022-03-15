import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tayseer2/Driver/getters.dart';
import 'package:tayseer2/report_an_accident/select_involved_car.dart';
import '../mainScreen/main_screen.dart';
import 'confirmation/confirmation_page.dart';

class select_your_carWidget extends StatefulWidget {
  final DateTime accTime;
  final Position accLocation;
  String accID, sender;
  select_your_carWidget(
      {Key? key,
      required this.accTime,
      required this.sender,
      required this.accLocation,
      required this.accID})
      : super(key: key);

  @override
  _select_your_carWidgetState createState() => _select_your_carWidgetState();
}

class _select_your_carWidgetState extends State<select_your_carWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List cars = [];

  var car_color, car_model, car_number;

  final databaseRef = FirebaseDatabase.instance.ref();
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  User user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    cars.clear();
    addtolist();
    super.initState();
  }

  void addtolist() async {
    int count = 0;
    var values;
    FirebaseFirestore.instance
        .collection('Driver')
        .doc(user.uid)
        .collection('Cars')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          car_number = element.data()['Car_plateNo'];
          car_model = element.data()['Car_model'];
          car_color = element.data()['Car_color'];

          values = {
            'car_model': '${car_model}',
            'car_color': '${car_color}',
            'car_number': '${car_number}',
            'in': 'سارية',
          };
        });
        cars.insert(count++, values);
      });
    });
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
              child: accidentChild(cars, this.context),
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
                    ' اختر مركبتك',
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
        ],
      ),
    );
  }

  add() async {
    String acc = await addDetails();
    setState(() {
      widget.accID = acc;
    });

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (c) => SelectCarInvolvedCarsPageWidget(
                  accID: widget.accID,
                  accTime: widget.accTime,
                  accLocation: widget.accLocation,
                )));
  }

  Future<String> addDetails() async {
    DocumentReference accID =
        await FirebaseFirestore.instance.collection('Accident').add({
      'Date_time': widget.accTime,
      'Cars_Involved': FieldValue.arrayUnion([
        {
          'Car_color': car_color,
          'Car_model': car_model,
          'Car_plateNo': car_number,
        }
      ]),
      'Drivers_Involved': FieldValue.arrayUnion([
        {
          'name': await getName(user.uid),
          'Driver_Id': await getNatID(user.uid),
          'uid': user.uid,
        }
      ]),
      'Location':
          GeoPoint(widget.accLocation.latitude, widget.accLocation.longitude)
    });

    return accID.id;
  }

  Widget accidentChild(data, context) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Container(
                    width: 360,
                    height: 230,
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 7, 10, 0),
                                    child: Text(
                                      '${data[i]['car_model']}',
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 7, 10, 0),
                                  child: Text(
                                    ': نوع السيارة ',
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 7, 10, 0),
                                    child: Text(
                                      '${data[i]['car_color']}',
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 7, 10, 0),
                                  child: Text(
                                    ': اللون ',
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
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 7, 10, 0),
                                    child: Text(
                                      '${data[i]['car_number']}',
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 7, 10, 0),
                                  child: Text(
                                    ': رقم اللوحة ',
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 7, 10, 0),
                                    child: Text(
                                      '${data[i]['in']}',
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 7, 10, 0),
                                  child: Text(
                                    ': حالة التأمين ',
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
                        const SizedBox(
                          height: 16.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Colors.black87,
                                  primary: Color(0xFF92D9E3),
                                  fixedSize: Size(129, 20),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    car_color = data[i]['car_color'];
                                    car_model = data[i]['car_model'];
                                    car_number = data[i]['car_number'];
                                  });
                                  widget.accTime.isBefore(
                                          DateTime.parse('2000-02-28'))
                                      ? showSnack()
                                      : add();
                                },
                                child: Text(
                                  'اختيار ',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  showSnack() async {
    await FirebaseFirestore.instance
        .collection('Accident')
        .doc(widget.accID)
        .update({
      'Cars_Involved': FieldValue.arrayUnion([
        {
          'Car_color': car_color,
          'Car_model': car_model,
          'Car_plateNo': car_number
        }
      ])
    });
    /*  SnackBar snackbar = SnackBar(
        content: Text('تم الاختيار بنجاح', textAlign: TextAlign.center));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);*/
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (c) => ConfirmationPageWidget(
                accidentID: widget.accID, sender: widget.sender)));
  }
}
