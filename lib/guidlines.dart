import 'dart:core';

import 'package:flutter/material.dart';

import '../mainScreen/main_screen.dart';

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
              child: Container(
                height: 400.0,
                width: 200.0,
                child: Column(children: [
                  const SizedBox(
                    height: 100.0,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 60, 0),
                    child: Text(
                      '١- عند تعرضك لحادث مروري اضغط زر تبليغ\n' +
                          '   عن حادث   '
                              '\n' +
                          '\n ' +
                          '٢- حدد السيارة التي وقع عليها الحادث' +
                          '\n' +
                          '\n ' +
                          '٣- حدد السيارة/السيارات المشاركة في الحادث' +
                          '\n' +
                          '\n ' +
                          '٤- قم بانتظار الطرف الآخر لتأكيد الحادث' +
                          '\n' +
                          '\n ' +
                          '٥- بعد تأكيد الحادث من الطرف الآخر سيتم عرض تقرير بتفاصيل الحادث ونسبة الخطأ',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  Container(
                    height: 250,
                    width: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/images/tayseer.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  )
                ]),
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
        ],
      ),
    );
  }
}
