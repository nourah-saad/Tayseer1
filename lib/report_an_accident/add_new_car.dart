import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tayseer2/report_an_accident/select_involved_car.dart';

import '../global/global.dart';
import '../notification/notification.dart';
import 'confirmation/confirmation_loading_page.dart';

class AddCarManuallyWidget extends StatefulWidget {
  final DateTime accTime;
  final String accID;
  final Position accLocation;
  const AddCarManuallyWidget(
      {Key? key,
      required this.accTime,
      required this.accID,
      required this.accLocation})
      : super(key: key);

  @override
  _AddCarManuallyWidgetState createState() => _AddCarManuallyWidgetState();
}

class _AddCarManuallyWidgetState extends State<AddCarManuallyWidget> {
  late TextEditingController textController;
  final formKey = GlobalKey<FormState>();
  var Drivername, driverid, uid;
  final scaffoldKey = GlobalKey<FormState>();
  var isfound = false;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  void addDetails(var Drivername, var driverid, var uid) async {
    FirebaseFirestore.instance.collection('Accident').doc(widget.accID).update({
      'Drivers_Involved': FieldValue.arrayUnion([
        {
          'name': Drivername,
          'Driver_Id': driverid,
          'uid': uid,
        }
      ]),
      'Accident_id': widget.accID
    });
  }

  void lookforacar(var plateNo) async {
    print("${plateNo}");

    await findcar(plateNo).then((value) {
      print("i am insud then ${isfound}");

      if (!isfound) {
        // isfound is still false which menas car is not found اذا كانت اي شي ماعدا ترو ادخل

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.clear_rounded,
                  color: Color(0xFF46494D),
                  size: 50,
                ),
                Text('!عذرًا'),
              ],
            ),
            content: Text(
              'لم يتم العثور على السيارة .. تأكد من كتابة رقم اللوحة بشكل صحيح',
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonTheme(
                      minWidth: 25.0,
                      height: 25.0,
                      child: ElevatedButton(
                          key: Key('OkButton'),
                          child: Text('حسنا',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Color(0xFF85BBC2)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
      setState(() {
        isfound = false;
      });
    });
  }

  Future<void> findcar(var plateNo) async {
    await FirebaseFirestore.instance
        .collection('Driver')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) async {
        await FirebaseFirestore.instance
            .collection('Driver')
            .doc(element.id)
            .collection('Cars')
            .where("Car_plateNo", isEqualTo: "$plateNo")
            .get()
            .then((querySnapshot) async {
          final list = querySnapshot.docs;

          if (!list.isEmpty) {
            print("car is found yaaaay");
            final String carid = list[0].id;
            print("${carid}");
            setState(() {
              Drivername = element.data()['name'].toString();
              driverid = element.data()['Driver_Id'].toString();
              uid = element.id.toString();

              isfound = true;
            });
            addDetails(Drivername, driverid, uid);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ConfirmationLoadingPageWidget()));
            sendNotification(
                receiver: element.id,
                title: 'تأكيد الحادث',
                msg:
                    'يدعوك ${driverModelCurrentInfo!.name} لتأكيد وقوع حادث، يرجى النقر للتأكيد أو الرفض',
                accID: widget.accID,
                sender: '${user.uid}',
                type: 'ques',
                accLocation: widget.accLocation,
                accTime: widget.accTime);
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                      padding: EdgeInsetsDirectional.fromSTEB(195, 30, 0, 0),
                      child: Text(
                        'رقم اللوحة*',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: 'Noto Sans',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 0),
                      child: TextFormField(
                        key: Key('enterManuallyField'),
                        controller: textController,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 10,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 10,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Color(0xFFA6C9CF),
                        ),
                        style: TextStyle(
                          fontFamily: 'Noto Sans',
                        ),
                        textAlign: TextAlign.center,
                        validator: (val) {
                          if (val!.trim().isEmpty) {
                            return 'الرجاء  ادخال رقم ';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                            child: ElevatedButton(
                              key: Key('enterManuallyButton'),
                              style: ElevatedButton.styleFrom(
                                onPrimary: Colors.black87,
                                primary: Color(0xFF85BBC2),
                                fixedSize: Size(200, 50),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                ),
                              ),
                              onPressed: () {
                                lookforacar(textController.text);
                                print("false");
                                bool _isValid =
                                    formKey.currentState!.validate();
                                if (_isValid) {
                                  print("true");
                                }
                              },
                              child: Text(
                                "اضافة",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ),
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
                    builder: (context) => SelectCarInvolvedCarsPageWidget(
                        accTime: widget.accTime,
                        accID: widget.accID,
                        accLocation: widget.accLocation),
                  ),
                  (r) => false,
                ),
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
                        'إضافة سيارة',
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
      ),
    );
  }
}
