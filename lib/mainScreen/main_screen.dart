import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tayseer2/Tracking/Tracking.dart';
import 'package:tayseer2/tapPages/chat.dart';
import 'package:tayseer2/tapPages/home.dart';
import 'package:tayseer2/tapPages/my_account.dart';
import 'package:tayseer2/tapPages/notifications.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 3;

  final screen = [
    const ChatPage(),
    const NotificationPage(),
    const MyAccount(),
    const HomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.chat, size: 30),
      const Icon(Icons.notifications, size: 30),
      const Icon(Icons.account_box, size: 30),
      const Icon(Icons.home, size: 30),
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
            backgroundColor: Colors.white,
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
