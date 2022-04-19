import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../mainScreen/main_screen.dart';

class ContactWithNajem extends StatefulWidget {
  const ContactWithNajem({Key? key}) : super(key: key);

  @override
  _ContactWithNajemState createState() => _ContactWithNajemState();
}

class _ContactWithNajemState extends State<ContactWithNajem> {
  get scaffoldKey => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFD8EBEE),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 60, 0, 0),
            child: IconButton(
                icon: new Icon(
                  Icons.chevron_left,
                  size: 50,
                ),
                color: Color(0xFF46494D),
                //size: 50,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                }),
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
          Center(
            child: Container(
              height: 500,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 170,
                        width: 300,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.mail,
                              color: Color(0xFF46494D),
                              size: 25,
                            ),
                            Text(
                              'Najem@gmail.com',
                              style: TextStyle(
                                  color: Color(0xFF46494D), fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        await FlutterPhoneDirectCaller.callNumber(
                            "+966538456777");
                      },
                      child: Container(
                        height: 170,
                        width: 300,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.call,
                              color: Color(0xFF46494D),
                              size: 25,
                            ),
                            Text(
                              '199033',
                              style: TextStyle(
                                  color: Color(0xFF46494D), fontSize: 17),
                            ),
                          ],
                        ),
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
