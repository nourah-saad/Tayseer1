import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tayseer2/tapPages/home.dart';
import 'package:tayseer2/tapPages/notifications.dart';
import '../Tracking/Tracking.dart';
import '../dummy_view/dummy_Screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 2;

  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  final screen = [
    const NotificationPage(),
    Dummy_Screen(controller_tab: tabController),
    const HomePage(),
  ];

  static get tabController => null;
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.notifications, size: 30),
      const Icon(
        Icons.account_box,
        size: 30,
        key: Key('profileButton'),
      ),
      const Icon(
        Icons.home,
        size: 30,
        key: Key('homeButton'),
      ),
    ];
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFD8EBEE),
        body: screen[index],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: const IconThemeData(color: Color(0xFFD8EBEE)),
          ),
          child: CurvedNavigationBar(
            color: const Color(0xFF85BBC2),
            backgroundColor: Color(0xFFD8EBEE),
            height: 60,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            index: index,
            items: items,
            onTap: (index) => setState(() => this.index = index),
          ),
        ),
      ),
    );
  }
}
