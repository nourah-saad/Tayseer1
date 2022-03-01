import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

import '../mainScreen/main_screen.dart';
import 'add_new_car.dart';

class select_involved_carWidget extends StatefulWidget {
  const select_involved_carWidget({Key? key}) : super(key: key);

  @override
  _select_involved_carWidgetState createState() => _select_involved_carWidgetState();
}

class _select_involved_carWidgetState extends State<select_involved_carWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List cars = [];

  var car_color , car_model , car_number ;
 
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
           car_model = '${values.toString()}';
            if(key == 'Date_time')
           car_color = '${values.toString()}';
            if(key == 'Date_time')
           car_number = '${values.toString()}';
 
              value = {
          'car_model': '${car_model}',
          'car_color': '${car_color}',
          'car_number': '${car_number}',
           'in' :'سارية',
         
        };
        
      });

    });
 cars.insert(count++, value); 
    });


    });

    });
    

  
         var value1 = {
          'car_model': ' تويوتا',
          'car_color': 'كحلي',
          'car_number': 'ا ب ع ٦٦٦٣',
          'in' :'سارية',
         
        };
                 var value2 = {
          'car_model': ' مرسيدس',
          'car_color': 'اسود',
          'car_number': 'ق ل ب ٥٥٥٥',
           'in' :'سارية',
         
        };
                         value3 = {
          'car_model': ' هونداي',
          'car_color': 'ابيض',
          'car_number': 'س د ر ٨٩٠٠',
           'in' :'سارية',
         
        };
     
              var value4 = {
          'car_model': ' هونداي',
          'car_color': 'احمر',
          'car_number': 'ا س س ٩٩٨٨',
           'in' :'سارية',
         
        };
cars.insert(count++, value1);
cars.insert(count++, value2);
cars.insert(count++, value3);
cars.insert(count++, value4);

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
              
              child: accidentChild(cars, this.context),
              
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
          Align(
            alignment: AlignmentDirectional(0, -0.82),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Text(
                    '  حدد السيارة المشاركة بالحادث',
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
 Widget accidentChild(data , context) {
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
                      height: 200,
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
                                    '${data[i]['car_model']}', textAlign: TextAlign.right ,
                                    
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
                                    ': نوع السيارة ', textAlign: TextAlign.right ,
                                    
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
                                    '${data[i]['car_color']}', textAlign: TextAlign.right ,
                                    
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
                                    ': اللون ', textAlign: TextAlign.right ,
                                    
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
                                 
                                  
          
                                  ],),


                                 Expanded(child:  Padding(
                                 
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 7, 10, 0),
                                  child: Text(
                                    '${data[i]['car_number']}', textAlign: TextAlign.right ,
                                    
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
                                    ': رقم اللوحة ', textAlign: TextAlign.right ,
                                    
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                       fontSize: 18,
                                      
                                    ),
                                  ),
                                  ),
                


                                  ],
                                  
                                  
                                  
                                  
                                  ),
              

             Row(
  crossAxisAlignment: CrossAxisAlignment.start, 
                               children: [
                                 Expanded(child:  Padding(
                                 
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 7, 10, 0),
                                  child: Text(
                                    '${data[i]['in']}', textAlign: TextAlign.right ,
                                    
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
                                    ': حالة التأمين ', textAlign: TextAlign.right ,
                                    
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                       fontSize: 18,
                                      
                                    ),
                                  ),
                                  ),
          
                                  ],),

                                    ],),
                                           const SizedBox(
            height: 16.0,
          ),

           Column(
                      crossAxisAlignment: CrossAxisAlignment.center,      
                           children: [
                                         Align(
                                           alignment:Alignment.center,
                                           child: ElevatedButton(
                                   
  style: ElevatedButton.styleFrom(
    
  onPrimary: Colors.black87,
  primary: Color(0xFF92D9E3),
  fixedSize: Size(129, 20),
  padding: EdgeInsets.symmetric(horizontal: 16),
  
    
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular( 12)),
  ),),
  
  onPressed: () {  print('Data : ${data}'); },
  child: Text('اختيار ', 
    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                       fontSize: 17,
                                      
                                    ),
  
  
  ),
), )
                             

],),

                              ],
                            ),
                    

                    ),
                    
                  ),
                        
                ],
              ),
      Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child:               
                      ElevatedButton(
                                   
  style: ElevatedButton.styleFrom(
    
  onPrimary: Colors.black87,
  primary: Color(0xFF85BBC2),
  fixedSize: Size(220, 50),
  padding: EdgeInsets.symmetric(horizontal: 16),
  
    
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular( 25)),
  ),),
  
   onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => AddCarManuallyWidget())); 
              },
  child: Text(" اضافة سيارة أخرى",
    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                       fontSize: 17,
                                       color: Colors.black,
                                    ),
  
  
  ),
),),
              ],),
      ],
    );
  }