import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../FlutterFlow/FlutterFlowTheme.dart';
import 'package:flutter/material.dart';
import '../fault_assessment/calculateFault.dart';

class ConfirmedPage extends StatefulWidget {
  final String status;
  final String reciever;
  final String sender;
  final String accID;
  final bool process;

  const ConfirmedPage(
      {Key? key,
      required this.status,
      required this.reciever,
      required this.sender,
      required this.accID,
      required this.process})
      : super(key: key);

  @override
  _ConfirmedPageState createState() => _ConfirmedPageState();
}

class _ConfirmedPageState extends State<ConfirmedPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (widget.process) {
      proccessAcc(
          accID: widget.accID,
          driverID: widget.reciever,
          involvedID: widget.sender,
          status: widget.status);
    }

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
            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: Color(0xFFD8EBEE),
                borderRadius: BorderRadius.circular(30),
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Color(0xFF85BBC2),
                  width: 20,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 200),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.status == 'مقبول' ? 'تم القبول ' : 'تم الرفض',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          widget.status == 'مقبول'
                              ? Icons.check_rounded
                              : Icons.cancel_outlined,
                          color: Color(0xFF46494D),
                          size: 70,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2),
                        Text('بانتظار اكتمال تقرير الحادث',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontWeight: FontWeight.w600,
                            )),
                        SpinKitThreeBounce(
                          size: 20,
                          color: Color(0xFF46494D),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 60, 0, 0),
            child: Icon(
              Icons.chevron_left,
              color: Color(0xFF46494D),
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
