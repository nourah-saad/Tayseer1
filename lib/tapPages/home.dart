import 'package:flutter/material.dart';
import 'package:tayseer2/global/global.dart';
import 'package:tayseer2/guidlines.dart';
import 'package:tayseer2/notification/notification.dart';
import 'package:tayseer2/widgets/my_drawer.dart';
import '../contact_with_Najem/contact_with_najem.dart';
import '../report_an_accident/mapScreen/map_screen.dart';
import '../view_accidents/view_accidents_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get scaffoldKey => null;

  @override
  void initState() {
    requestPermission();
    loadFCM();
    listenFCM();
    setToken();
    super.initState();
  }

  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
  var n = driverModelCurrentInfo!.name;
  var e = driverModelCurrentInfo!.did.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFD8EBEE),
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0, -0.82),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Text(
                    'الصفحة الرئيسية',
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
                            height: 60,
                          ),
                          Container(
                            width: 345,
                            height: 190,
                            decoration: BoxDecoration(
                              color: Color(0xFFD8EBEE),
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 15.0,
                                  spreadRadius: 1.0,
                                ),
                                BoxShadow(
                                  color: Color(0xFFD8EBEE),
                                  offset: Offset(-2.0, -4.0),
                                  blurRadius: 15.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromARGB(61, 255, 255, 255),
                                      ),
                                      child: const Icon(
                                        Icons.person,
                                        size: 80,
                                        color: Color(0xFF46494D),
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      n.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF46494D),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      e.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF46494D),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 90, 0, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Colors.black87,
                                  primary: const Color(0xFFEB6666),
                                  fixedSize: const Size(200, 50),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => MapScreen(
                                                accTime: DateTime.now(),
                                              )));
                                },
                                child: const Text(
                                  "تبليغ عن حادث",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: Color(0xFF46494D),
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 325, bottom: 13, top: 29),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const <Widget>[
                                Text(
                                  'الخدمات',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Color(0xFF46494D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (c) =>
                                                  ContactWithNajem()));
                                    },
                                    child: Container(
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
                                            'تواصل مع نجم',
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
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (c) =>
                                                  const guidelines()));
                                    },
                                    child: Container(
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
                                            Icons.assignment_outlined,
                                            color: Color(0xFF46494D),
                                            size: 25,
                                          ),
                                          Text(
                                            'الية عمل تيسير',
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
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (c) =>
                                                  ViewAccidentsWidget()));
                                    },
                                    child: Container(
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
                                            Icons.note_outlined,
                                            color: Color(0xFF46494D),
                                            size: 25,
                                          ),
                                          Text(
                                            'البلاغات السابقة',
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
