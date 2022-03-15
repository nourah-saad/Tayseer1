import 'package:flutter/material.dart';
import 'package:tayseer2/global/global.dart';
import 'package:tayseer2/splashScreen/splash_screen.dart';
import 'package:tayseer2/view_accidents/view_accidents_widget.dart';

class MyDrawer extends StatefulWidget {
  String? name;
  String? email;

  MyDrawer({this.name, this.email});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //drawer header
          Container(
            height: 165,
            color: Color(0xFFD8EBEE),
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFFD8EBEE)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 
                 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.email.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                   const SizedBox(
                    width: 16,
                  ),
                   const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 12.0,
          ),

          //drawer body
           GestureDetector(
        onTap: ()async {
            await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewAccidentsWidget(),
                        ),
                        (r) => false,
                      );
        },
        child :
                    Container(
                      width: 310,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF85BBC2),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                              child: Text(
                                'البلاغات السابقة',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF46494D),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.note_outlined,
                              color: Color(0xFF46494D),
                              size: 28,
                            ),
                          ],
                          
                        ),
                      ),
                    ),
                    ),
  const SizedBox(
            height: 12.0,
          ),


          Container(
                        width: 310,
                        height: 50,
                        decoration: BoxDecoration(
                          color:Color(0xFF85BBC2),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                child: Text(
                                  'آلية عمل تيسير',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF46494D),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.assignment_outlined,
                                color: Color(0xFF46494D),
                                size: 28,
                              ),
                            ],
                          ),
                        ),
                      ),
                        const SizedBox(
            height: 12.0,
          ),

Container(
                        width: 310,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF85BBC2),
                          shape: BoxShape.rectangle,
                        ),
         child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                child: Text(
                                  'تحدث معنا',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF46494D),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.chat_bubble_outline_rounded,
                                color: Color(0xFF46494D),
                                size: 28,
                              ),
                            ],
                          ),
                        ),
),
             const SizedBox(
            height: 12.0,
          ),

GestureDetector(
        onTap: () {
              fAuth.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const MySplashScreen()));
            },
        child :
                    Container(
                      width: 310,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF85BBC2),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                              child: Text(
                                 "تسجيل خروج",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF46494D),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(
                             Icons.logout,
                              color: Color(0xFF46494D),
                              size: 28,
                            ),
                          ],
                          
                        ),
                      ),
                    ),
                    ),
        

          const SizedBox(
            height: 250,
          ),
         Align(
                alignment: AlignmentDirectional(0, 0.66),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 7, 0),
                      child: Text(
                        'تواصل مع نجم',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF46494D),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                const SizedBox(
            height: 16.0,
          ),

               Align(
                alignment: AlignmentDirectional(0, 0.75),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                        child: Text(
                          '0543678927',
                          style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF46494D),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        ),
                      ),
                      Icon(
                        Icons.call_rounded,
                        color: Color(0xFF46494D),
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
      const SizedBox(
            height: 12.0,
          ),


             Align(
                alignment: AlignmentDirectional(0, 0.75),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                        child: Text(
                          "Najem@gmail.com",
                          style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF46494D),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        ),
                      ),
                      Icon(
                      Icons.mail_outline_rounded,
                        color: Color(0xFF46494D),
                        size: 24,
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
