import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../FlutterFlow/FlutterFlowTheme.dart';
import '../guidlines.dart';
import '../mainScreen/main_screen.dart';
import '../report_an_accident/mapScreen/map_screen.dart';
import '../view_accidents/view_accidents_widget.dart';

class ContactWithNajem extends StatefulWidget {
  const ContactWithNajem({Key? key}) : super(key: key);

  @override
  _ContactWithNajemState createState() => _ContactWithNajemState();
}

class _ContactWithNajemState extends State<ContactWithNajem> {
  get scaffoldKey => null;
  final controllerTo = "Nourahsaad1999@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xff74BDC6),
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
                    'تواصل مع نجم',
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
          Stack(
            children: [
              Center(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 150,
                          ),
                          Container(
                            height: 500,
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    key: Key('emailNajm'),
                                    onTap: () async {
                                      final url = 'mailto:$controllerTo';
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      }
                                    },
                                    child: Container(
                                      height: 170,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFD8EBEE),
                                        borderRadius: BorderRadius.circular(10),
                                        shape: BoxShape.rectangle,
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(1.0, 1.0),
                                            blurRadius: 5.0,
                                            spreadRadius: 1.0,
                                          ),
                                          BoxShadow(
                                            color: Color(0xFFD8EBEE),
                                            offset: Offset(-1.0, -1.0),
                                            blurRadius: 5.0,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.email,
                                            color: Color(0xFF46494D),
                                            size: 25,
                                          ),
                                          Text(
                                            'Najem@gmail.com',
                                            style: TextStyle(
                                                color: Color(0xFF46494D),
                                                fontSize: 17),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    key: Key('callNajm'),
                                    onTap: () async {
                                      await FlutterPhoneDirectCaller.callNumber(
                                          "+966538456777");
                                    },
                                    child: Container(
                                      height: 170,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFD8EBEE),
                                        borderRadius: BorderRadius.circular(10),
                                        shape: BoxShape.rectangle,
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(1.0, 1.0),
                                            blurRadius: 5.0,
                                            spreadRadius: 1.0,
                                          ),
                                          BoxShadow(
                                            color: Color(0xFFD8EBEE),
                                            offset: Offset(-1.0, -1.0),
                                            blurRadius: 5.0,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.call,
                                            color: Color(0xFF46494D),
                                            size: 25,
                                          ),
                                          Text(
                                            '920000560',
                                            style: TextStyle(
                                                color: Color(0xFF46494D),
                                                fontSize: 17),
                                          ),
                                        ],
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
