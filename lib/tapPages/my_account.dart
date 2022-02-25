import 'package:flutter/material.dart';
import 'package:tayseer2/global/global.dart';
import 'package:tayseer2/splashScreen/splash_screen.dart';

import '../widgets/my_drawer.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}
GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sKey,
      endDrawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xFFD8EBEE),
        ),
        child: MyDrawer(
          name: 'khawla',
          //driverModelCurrentInfo!.name,
          email: 'khawlaff5@gmail.com',
          //driverModelCurrentInfo!.email,
        ),
      ),
      backgroundColor: Color(0xFFD8EBEE),
      body:Stack(
        children: [
          const SizedBox(
            height: 100,
          ),
          Positioned(
            top: 55,
            right: 20,
            child: GestureDetector(
              onTap: () {
                sKey.currentState!.openEndDrawer();
              },
              child: const CircleAvatar(
                backgroundColor: Color(0xFFD8EBEE),
                child: Icon(
                  Icons.menu,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Center(
            child: 
               ElevatedButton(
                                   
  style: ElevatedButton.styleFrom(
    
  onPrimary: Colors.black87,
  primary: Color(0xFF85BBC2),
  fixedSize: Size(200, 50),
  padding: EdgeInsets.symmetric(horizontal: 16),
  
    
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular( 25)),
  ),),
  
   onPressed: () {
          fAuth.signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => const MySplashScreen()));
        },
  child: Text("تسجيل خروج",
    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                       fontSize: 17,
                                       color: Colors.black,
                                    ),
  
  
  ),
)
            
            
            
            
          
          ),
        ],
      ),
      );
    
    
    
    
    
    
  /*   Center(
      child: ElevatedButton(
        child: const Text(
          "Sign Out",
        ),
        onPressed: () {
          fAuth.signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => const MySplashScreen()));
        },
      ),
    );
     */
  }
}
