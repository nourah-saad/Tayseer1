import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

//import 'package:tayseer/home_page/home_page_widget.dart';


import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class ViewAccidentsWidget extends StatefulWidget {
  const ViewAccidentsWidget({Key? key}) : super(key: key);

  @override
  _ViewAccidentsWidgetState createState() => _ViewAccidentsWidgetState();
}

class _ViewAccidentsWidgetState extends State<ViewAccidentsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List accidents = [];
  var location;
  var time;
  var id;
  var dataaa= 'new ' ;
   final databaseRef = FirebaseDatabase.instance.ref();
  final Future<FirebaseApp> _future = Firebase.initializeApp();


@override
  void initState() {
   addtolist();
    super.initState();
  }

   void addtolist() async{

       int count = 0;

 var value3;
        final userProfileDetails = await FirebaseDatabase.instance
        .ref()
        .child("Accident")
        .once()
        .then((DatabaseEvent DatabaseEvent) {
Map<dynamic, dynamic> values = DatabaseEvent.snapshot.value as Map;
    values.forEach((key, values) async {
 var value;

     final accidentsy =  await FirebaseDatabase.instance
        .ref()
        .child("Accident").child('${key}')
        .once()
        .then(( ADatabaseEvent) {
Map<dynamic, dynamic> Avalues = ADatabaseEvent.snapshot.value as Map;
    Avalues.forEach((key, values) {
      print('${key} : ${values}');
 setState(() {
           if(key == 'Location')
           location = '${values.toString()}';
            if(key == 'Date_time')
           time = '${values.toString()}';
            if(key == 'Date_time')
           id = '${values.toString()}';
 
              value = {
          'location': '${location}',
          'time': '${time}',
          'id': '${time}',
         
        };
        
      });

    });
 accidents.insert(count++, value); 
    });


    });

    });
    

    
/* 

      setState(() {
           if(key == 'Location')
           location = '${values.toString()}';
            if(key == 'Date_time')
           time = '${values.toString()}';
            if(key == 'Date_time')
           id = '${values.toString()}';
 
             var value = {
          'location': '${location}',
          'time': '${time}',
          'id': '${time}',
         
        };
        accidents.insert(count++, value); 
      });
   
       */
      // print('${key} : ${values}');
     //R accidents.insert(count++, values);
         var value1 = {
          'location': 'اضغط هنا',
          'time': '89-feb-21',
          'id': '15:40:10',
         
        };
                 var value2 = {
          'location': 'اضغط هنا',
          'time': '89-feb-21',
          'id': '15:40:10',
         
        };
                         value3 = {
          'location': 'اضغط هنا',
          'time': '89-feb-21',
          'id': '15:40:10',
         
        };
     
              var value4 = {
          'location': 'اضغط هنا',
          'time': '89-feb-21',
          'id': '15:40:10',
         
        };
accidents.insert(count++, value1);
accidents.insert(count++, value2);
accidents.insert(count++, value3);
accidents.insert(count++, value4);

//accidents.insert(count++, value);
  // });
   
     //    } );
      

    

   }
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
              child: accidentChild(accidents),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 60, 0, 0),
            child:   IconButton(
              icon : new Icon(Icons.chevron_left , size: 50,),
              color: Color(0xFF46494D),
              //size: 50,
              onPressed: () {}
              
              /*async =>   a wait Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePageWidget(),
                        ),
                        (r) => false,
  ) */
,  
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
                    'البلاغات السابقة',
                    textAlign: TextAlign.center,

                    style:  TextStyle(fontSize: 30 , color:  Color(0xFF46494D) , fontFamily: 'Poppins', ),
                    
                  
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
 Widget accidentChild(data) {
    return ListView(
      children: [

  
        for (var i = 0; i < data.length; i++)

        Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: Container(
                      width: 360,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Color(0xFF85BBC2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                               
                             crossAxisAlignment: CrossAxisAlignment.end, 
                            //  mainAxisSize: MainAxisSize.max,
                              children: [

                                
                                 Column(
                                   
                                   crossAxisAlignment: CrossAxisAlignment.end, 
                                    children: [
                                      Row(
  crossAxisAlignment: CrossAxisAlignment.start, 
                               children: [
                                 Expanded(child:  Padding(
                                 
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 7, 10, 0),
                                  child: Text(
                                    '${data[i]['location']}', textAlign: TextAlign.right ,
                                    
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                       fontSize: 18,
                                      
                                    ),
                                  ),
                                  ),
                                  ), 
                                    Padding(
                                 
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 7, 10, 0),
                                  child: Text(
                                    ': الموقع ', textAlign: TextAlign.right ,
                                    
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                       fontSize: 18,
                                      
                                    ),
                                  ),
                                  ),
                                  
                                  
                                  
                                  ],),

                                  

                                          Row(
  crossAxisAlignment: CrossAxisAlignment.start, 
                               children: [
                                 Expanded(child:  Padding(
                                 
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 7, 10, 0),
                                  child: Text(
                                    '${data[i]['time']}', textAlign: TextAlign.right ,
                                    
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                       fontSize: 18,
                                      
                                    ),
                                  ),
                                  ),
                                  ), 
                                    Padding(
                                 
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 7, 10, 0),
                                  child: Text(
                                    ': التاريخ ', textAlign: TextAlign.right ,
                                    
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                       fontSize: 18,
                                      
                                    ),
                                  ),
                                  ),
          
                                  ],),

                                      Row(
  crossAxisAlignment: CrossAxisAlignment.start, 
                               children: [

                                 Row(
  crossAxisAlignment: CrossAxisAlignment.start, 
                               children: [
                                     Row(
     children: [
SizedBox(
  width: 17,
  
  
)


     ]
                             ),
                                 Row( children: [
                                 ElevatedButton(
                                   
  style: ElevatedButton.styleFrom(
    
  onPrimary: Colors.black87,
  primary: Color(0xFF92D9E3),
  fixedSize: Size(129, 20),
  padding: EdgeInsets.symmetric(horizontal: 16),
  
    
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular( 12)),
  ),),
  
  onPressed: () {  print('Data : ${data}'); },
  child: Text('عرض التقرير', 
    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                       fontSize: 17,
                                      
                                    ),
  
  
  ),
)
                                  ] ), 
                                  
          
                                  ],),


                                 Expanded(child:  Padding(
                                 
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 7, 10, 0),
                                  child: Text(
                                    '${data[i]['id']}', textAlign: TextAlign.right ,
                                    
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                       fontSize: 18,
                                      
                                    ),
                                  ),
                                  ),
                                  ), 
                                    Padding(
                                 
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 7, 10, 0),
                                  child: Text(
                                    ': الوقت ', textAlign: TextAlign.right ,
                                    
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                       fontSize: 18,
                                      
                                    ),
                                  ),
                                  ),
                


                                  ],
                                  
                                  
                                  
                                  
                                  ),
                         
                             
                             






                                    ],),

                              ],
                            ),
                    

                    ),
                  ),
                ],
              ),
     
              
      ],
    );
  }