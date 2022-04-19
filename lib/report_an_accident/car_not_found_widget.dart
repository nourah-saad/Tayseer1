
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../mainScreen/main_screen.dart';

class CarNotFoundWidget extends StatefulWidget {
  const CarNotFoundWidget({Key? key}) : super(key: key);

  @override
  _CarNotFoundWidgetState createState() => _CarNotFoundWidgetState();
}

class _CarNotFoundWidgetState extends State<CarNotFoundWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 200),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'عذراً...\nلم يتم العثور على\nالسيارة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF46494D),
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 60, 0, 0),
            child:   IconButton(
              icon : new Icon(Icons.chevron_left , size: 50,),
              color: Color(0xFF46494D),
              //size: 50,
              onPressed: ()         async =>   await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(),
                        ),
                        (r) => false,
  ) 
, 
              
     
            ),  
          ),
                  ],
                ),
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
        ],
      ),
    );
  }
}
