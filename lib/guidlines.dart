import 'dart:core';
import 'package:flutter/material.dart';

import 'mainScreen/main_screen.dart';

class guidelines extends StatefulWidget {
  const guidelines({Key? key}) : super(key: key);

  @override
  _guidelinesState createState() => _guidelinesState();
}

class _guidelinesState extends State<guidelines> {
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
                    'الية عمل تيسير',
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
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
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
                            Text(
                              '١- عند تعرضك لحادث مروري اضغط زر\n "تبليغ عن حادث"',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF46494D),
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
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
                            Text(
                              '٢- حدد سيارتك التي وقع عليها الحادث',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF46494D),
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
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
                            Text(
                              '٣- حددالسيارة/السيارات المشاركة في الحادث',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF46494D),
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
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
                            Text(
                              '٤- قم بانتظار الطرف الاخر لتاكيد الحادث',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF46494D),
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
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
                            Text(
                              '٥- بعد تاكيد الحادث من الطرف الاخر سيتم عرض التقرير بتفاصيل الحادث ونسبة الخطأ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF46494D),
                                fontSize: 17,
                              ),
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
