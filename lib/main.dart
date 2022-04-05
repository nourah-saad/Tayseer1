import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayseer2/authintication/login_screen.dart';
import 'package:tayseer2/infoHandler/app_info.dart';
import 'package:tayseer2/navigationService.dart';
import 'package:tayseer2/splashScreen/splash_screen.dart';

import 'assistants/assistant_methods.dart';
import 'authintication/signup_screen.dart';
import 'global/global.dart';
//import 'mapScreen/map_screen.dart';

//Nourah saad
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  fAuth.currentUser != null
      ? AssistantMethods.readCurrentOnlineDriverInfo()
      : null;
  runApp(
    MyApp(
      child: ChangeNotifierProvider(
        create: (context) => AppInfo(),
        child: MaterialApp(
          title: 'Drivers App',
          navigatorKey: navigationService.navigatorKey,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MySplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Widget? child;

  MyApp({this.child});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}
