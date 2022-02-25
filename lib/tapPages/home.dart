import 'package:flutter/material.dart';
import 'package:tayseer2/assistants/assistant_methods.dart';
import 'package:tayseer2/global/global.dart';
import 'package:tayseer2/mapScreen/map_screen.dart';
import 'package:tayseer2/widgets/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();

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


             SafeArea(
        child: Padding(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Color(0xFF85BBC2),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => MapScreen()));
              },
  child: Text("تبليغ عن حادث",
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
          ),
        ),
      ),         
            
            
          
          ),
        ],
      ),
    );
  }
}
