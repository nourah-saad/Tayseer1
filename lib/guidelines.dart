import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class guidelines extends StatefulWidget {
  const guidelines({Key? key}) : super(key: key);

  @override
  _guidelinesState createState() => _guidelinesState();
}

class _guidelinesState extends State<guidelines> {
  

  // final User user = FirebaseAuth.instance.currentUser;


 
  
  
  

  
      //cardetails_map = data['car_details'];

 

 

 

  @override
 Widget build(BuildContext context) {
    //user_data();


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              //  SingleChildScrollView(child:Container()),
              Container(
                  padding: EdgeInsets.all(25),
                  color: Color(0xff74BDC6),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: InkWell(
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black))),
                      Spacer(),
                      Container(
                        child: Text(
                          'تعليمات عمل تيسير',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Spacer(),
                    ],
                  )),
              Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: BoxDecoration(
                  color: Color(0xffD7ECED),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
  mainAxisSize: MainAxisSize.max,
  children: [
    Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 75, 35, 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '١- عند تعرضك لحادث مروري اضغط زر تبليغ\n عن حادث',
            textAlign: TextAlign.end,
             style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    ),
    Padding(
         padding: EdgeInsetsDirectional.fromSTEB(0, 10, 35, 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '٢- حدد السيارة التي وقع عليها الحادث',
             style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    ),
    Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 35, 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '٣- حدد السيارة/السيارات المشاركة في الحادث',
             style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    ),
    Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 20, 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '٤- قم بانتظار الطرف الآخر لتأكيد الحادث',
             style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    ),
    Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 35, 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '٥- بعد تأكيد الحادث من الطرف الآخر سيتم عرض \nتقرير بتفاصيل الحادث ونسبة الخطأ',
            textAlign: TextAlign.end,
            style: TextStyle(color: Colors.black, fontSize: 20),
           
           
          ),
        ],
      ),
    ),
  ],
)



                
                  // mainAxisAlignment: MainAxisAlignment.end,
                  
                
              ),
            ],
          ),
        ),
      ),
    );
    }
}