import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tayseer2/report_an_accident/select_involved_car.dart';

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
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Scaffold(
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
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'الرجاء  ادخال رقم الهويه/الإقامة';
                          }
                          if (val.length < 10) {
                            return 'الرجاء  ادخال رقم صحيح';
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
                                /*  Navigator.push(
                    context, MaterialPageRoute(builder: (c) => MapScreen())); */
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
                        'إضافة سيارة اخرى',
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
      ),
    );
  }
}
