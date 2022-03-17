import 'package:flutter/material.dart';
import 'package:tayseer2/tapPages/chat.dart';
import 'package:tayseer2/tapPages/home.dart';
import 'package:tayseer2/tapPages/my_account.dart';
import 'package:tayseer2/tapPages/notifications.dart';

//import '../dummy_view/dummy_Screen.dart';
import '../tapPages/dummy_Screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;

    });
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF85BBC2),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children:  [
         // HomePage(),
          Container(),
         // MyAccount(),
          Dummy_Screen(controller_tab:tabController),
          NotificationPage(),
          ChatPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "الصفحة الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "حسابي",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "الإشعارات",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "تحدث معنا",
          ),
        ],
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.black,
        backgroundColor: const Color(0xFFD8EBEE),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
      ),
    );
  }
}
