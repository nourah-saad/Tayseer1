import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../FlutterFlow/FlutterFlowTheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationLoadingPageWidget extends StatefulWidget {
  const ConfirmationLoadingPageWidget({Key? key}) : super(key: key);

  @override
  _ConfirmationLoadingPageWidgetState createState() =>
      _ConfirmationLoadingPageWidgetState();
}

class _ConfirmationLoadingPageWidgetState
    extends State<ConfirmationLoadingPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
                          'تم رفع البلاغ بنجاح',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.check_rounded,
                          color: Color(0xFF46494D),
                          size: 70,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                          child: Text(
                            'بانتظار تأكيد الحادث من الطرف الآخر',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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
