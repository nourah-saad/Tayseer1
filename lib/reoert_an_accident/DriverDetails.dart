import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tayseer2/reoert_an_accident/confirmation/confirmation_loading_page.dart';
import 'package:tayseer2/notification/notification.dart';

import '../Driver/getName.dart';
import '../FlutterFlow/FlutterFlowTheme.dart';
import '../FlutterFlow/FlutterFlowWidgets.dart';

class DriverDetails extends StatefulWidget {
  const DriverDetails(
      {Key? key,
      required this.inDriverName,
      required this.inDriverID,
      required this.accID})
      : super(key: key);
  final String inDriverName;
  final String inDriverID;
  final String accID;

  @override
  State<DriverDetails> createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 2,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          color: Color(0xFF85BBC2),
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Text(
                  'اسم مالك المركبة: ${widget.inDriverName}',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 50, 0, 0),
                    child: Text(
                      '||||||',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(60, 50, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        addDetails();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ConfirmationLoadingPageWidget()));
                        sendNotification(
                            receiver: widget.inDriverID,
                            title: 'تأكيد الحادث',
                            msg:
                                'يدعوك ${await getName(user.uid)} لتأكيد وقوع حادث، يرجى النقر للتأكيد أو الرفض',
                            accID: widget.accID,
                            sender: '${user.uid}',
                            type: 'ques');
                      },
                      text: 'اختيار',
                      options: FFButtonOptions(
                        width: 130,
                        height: 40,
                        color: Color(0xFF92D9E3),
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
      ),
    );
  }

  void addDetails() {
    FirebaseFirestore.instance.collection('Accident').doc(widget.accID).update({
      'Drivers_Involved': FieldValue.arrayUnion([
        {
          'name': widget.inDriverName,
          'uid': widget.inDriverID,
        }
      ]),
      'Accident_id': widget.accID
    });
  }
}
