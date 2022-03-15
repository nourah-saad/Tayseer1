
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tayseer2/view_accidents/view_accidents_widget.dart';
import 'package:intl/intl.dart';

class AccidentReportWidget extends StatefulWidget {
  final id;
  const AccidentReportWidget({ Key? key, this.id}) : super(key: key);

  @override
  _AccidentReportWidgetState createState() => _AccidentReportWidgetState();
}

class _AccidentReportWidgetState extends State<AccidentReportWidget> {
  @override
  void initState() {
    fetchdata();
   
    super.initState();
  }
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var address, adate, atime, time,status, accidentimage, driver1,car1,id1,falut1, driver2, car2,id2,falut2, accident_type;
  GeoPoint ? location;
  final  Accidents = FirebaseFirestore.instance.collection('Accident');
    final Cars = FirebaseFirestore.instance.collection('Car');
     final Drivers = FirebaseFirestore.instance.collection('Driver');
    void GetAddressFromLatLong(LatLng l)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(l.latitude, l.longitude);
   // print(placemarks);
    Placemark place = placemarks[0];
    setState(() {
       address = '${place.street} ${place.subLocality}, ${place.locality}';
    });
    print('the adrres is ${address}');
    
  }
Future<void> fetchdata() async {

var docSnapshot = await Accidents.doc(widget.id).get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();

      setState(() {
        //accident info

        location = data!['Location'];
        time = data['Date_time'].toDate();
        status = data['status'].toString();
        accidentimage = data['Accident_image'].toString();
        falut1= data['Fault_assessment'][0].toString();
         falut2= data['Fault_assessment'][1].toString();
accident_type =data['accident_type'].toString();
 });
print("-------------------------${falut1}-----------------------");

        //cars info (Cars collection)
  var driver1docid , driver2docid ;

       var car1_doc = await Cars.doc(data!['Cars_Involved'][0].toString()).get();
      
           if (car1_doc.exists) {
      Map<String, dynamic>? car1_data = car1_doc.data();
      setState(() {
          car1 = car1_data!['Car_plateNo'].toString();
          driver1docid=  car1_data['car_Driver_Id'].toString();
      });

      }

       var car2_doc = await Cars.doc(data['Cars_Involved'][1].toString()).get();
      
           if (car2_doc.exists) {
      Map<String, dynamic>? car2_data = car2_doc.data();
      setState(() {
          car2 = car2_data!['Car_plateNo'].toString();
          driver2docid=  car2_data['car_Driver_Id'].toString();
      });
  
      }
   

        //drivers info (drivers collection)

         var driver1_doc = await Drivers.doc(driver1docid).get();
      
           if (driver1_doc.exists) {
      Map<String, dynamic>? driver1_data = driver1_doc.data();
      setState(() {
          driver1 = driver1_data!['name'].toString();
          id1=  driver1_data['Driver_Id'].toString();
      });
  
      }

 var driver2_doc = await Drivers.doc(driver2docid).get();
      
           if (driver2_doc.exists) {
      Map<String, dynamic>? driver2_data = driver2_doc.data();
      setState(() {
          driver2 = driver2_data!['name'].toString();
          id2=  driver2_data['Driver_Id'].toString();
      });
  
      }



     
    }








 setState(() {
    adate = DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY).format(time!);
 atime = DateFormat.Hms().format(time!);
 });


 

 GetAddressFromLatLong(LatLng(location!.latitude ,location!.longitude));
   


  
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 40, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'الطرف الأول',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                                  Text(
                          '${driver1} ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '  :الإسم',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                            Text(
                          '${car1}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '  :رقم اللوحة',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                          Text(
                          '${id1} ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '  :رقم الهوية/الإقامة',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                            Text(
                          '${falut1}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '   :نسبة الخطأ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'الطرف الثاني',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                          Text(
                          '   ${driver2} ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '   :الإسم',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                         Text(
                          '${car2}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '  :رقم اللوحة',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${id2} ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '  :رقم الهوية/الإقامة',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                            Text(
                          '${falut2}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '   :نسبة الخطأ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                          Text(
                          '  ${address} ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '  :الموقع',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                           Text(
                          '${adate}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '  :التاريخ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                          Text(
                          '${atime}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          ' :الوقت',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                           Text(
                          '${status}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '  : حالة التقرير',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '  :تخطيط الحادث',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF46494D),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
  height: 17,
  
  
),
                  Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: accident_type == 'S1' ? AssetImage(
              'lib/images/accident1.png') : AssetImage(
              'lib/images/accident2.png') ,
          fit: BoxFit.fill,
        ),
        shape: BoxShape.rectangle,
      ),
    )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 60, 0, 0),
            child:  IconButton(
              icon : new Icon(Icons.chevron_left , size: 50,),
              color: Color(0xFF46494D),
              //size: 50,
              onPressed: ()         async =>   await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewAccidentsWidget(),
                        ),
                        (r) => false,
  ) 
, 
              
     
            ),  
          ),
          Align(
            alignment: AlignmentDirectional(0, -0.82),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Text(
                      'تقرير الحادث',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                     fontSize: 30 , color:  Color(0xFF46494D) , fontFamily: 'Poppins',
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

