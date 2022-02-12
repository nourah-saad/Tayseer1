import 'package:flutter/material.dart';
import 'package:tayseer2/global/global.dart';
import 'package:tayseer2/splashScreen/splash_screen.dart';

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
            color: const Color(0xFF85BBC2),
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF85BBC2)),
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
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
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 12.0,
          ),

          //drawer body
          GestureDetector(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                Icons.article_outlined,
                color: Colors.black,
              ),
              title: Text(
                "البلاغات السابقة",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                Icons.article_outlined,
                color: Colors.black,
              ),
              title: Text(
                "الية عمل تيسير",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                Icons.chat,
                color: Colors.black,
              ),
              title: Text(
                "تحدث معنا",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              fAuth.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const MySplashScreen()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: Text(
                "تسجيل خروج",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),

          const SizedBox(
            height: 250,
          ),
          const Text(
            "تواصل مع نجم",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            child: const Text(
              "0543678927",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              //to do
            },
          ),
          TextButton(
            child: const Text(
              "Najem@gmail.com",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              //to do
            },
          ),
        ],
      ),
    );
  }
}
