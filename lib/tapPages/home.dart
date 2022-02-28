import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tayseer2/assistants/assistant_methods.dart';
import 'package:tayseer2/global/global.dart';
import 'package:tayseer2/mapScreen/map_screen.dart';
import 'package:tayseer2/notification/notification.dart';
import 'package:tayseer2/selectInvolvedCars.dart/selectInvolvedCars.dart';
import 'package:tayseer2/widgets/my_drawer.dart';

import '../confirmation_page/confirmation_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    requestPermission();
    loadFCM();
    listenFCM();
    setToken();
    super.initState();
  }

  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sKey,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFF85BBC2),
        ),
        child: MyDrawer(
            //  name: driverModelCurrentInfo!.name,
            //   email: driverModelCurrentInfo!.email,
            ),
      ),
      backgroundColor: const Color(0xFF85BBC2),
      body: Stack(
        children: [
          const SizedBox(
            height: 100,
          ),
          Positioned(
            top: 55,
            right: 20,
            child: GestureDetector(
              onTap: () {
                sKey.currentState!.openDrawer();
              },
              child: const CircleAvatar(
                backgroundColor: Color(0xFF85BBC2),
                child: Icon(
                  Icons.menu,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder:
                            (c) => /*MapScreen()*/ SelectCarInvolvedCarsPageWidget(
                                accTime: DateTime.now())));
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFD8EBEE),
              ),
              child: const Text(
                "تبليغ عن حادث",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
