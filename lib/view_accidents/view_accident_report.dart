
import 'package:flutter/material.dart';
import 'package:tayseer2/view_accidents/view_accidents_widget.dart';


class AccidentReportWidget extends StatefulWidget {
  final id;
  const AccidentReportWidget({ Key? key, this.id}) : super(key: key);

  @override
  _AccidentReportWidgetState createState() => _AccidentReportWidgetState();
}

class _AccidentReportWidgetState extends State<AccidentReportWidget> {
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
                          '${widget.id} ',
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
                          ' ه ه ه ٨٨٩٩',
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
                          '١١٠٨٨٧٦٥٤٣',
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
                          '١٠٠٪',
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
                          '   أحمد السالم',
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
                          ' ه ت ه ٠٠٩٩',
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
                          '١١٠٨٨٧٦٥٤٣',
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
                          '١٠٠٪',
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
                          '  طريق الملك عبدالله',
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
                          '١٢/١/٢٠٢٢',
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
                          '١٠:١١',
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
                          'مؤكدة',
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
