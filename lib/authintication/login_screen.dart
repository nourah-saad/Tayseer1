

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tayseer2/authintication/signup_screen.dart';
import 'package:tayseer2/global/global.dart';
import 'package:tayseer2/mainScreen/main_screen.dart';
import 'package:tayseer2/splashScreen/splash_screen.dart';
import 'package:tayseer2/widgets/progress_dialog.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController didTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
   late bool passwordVisibility;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  validateForm() {
    if (didTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "ID is required");
    } else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password is required.");
    } else {
      loginDriverNow();
    }
  }

  loginDriverNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "فضلا انتظر",
          );
        });



     DatabaseReference ref =
        FirebaseDatabase.instance.ref("drivers");
        Query query = ref..child("did").orderByChild("did").equalTo(didTextEditingController.text.trim());
        DataSnapshot event = await query.get();
        print(event.exists);
     
        
        // if(query.get()==null){
         //  print("SSs");
        
     //}
       
        
     // Query query = driversRef.child("did").orderByChild("did").equalTo( emailTextEditingController.text.trim());
      

    

        
          
    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
      email: '${didTextEditingController.text.trim()}@gmail.com',
      password: passwordTextEditingController.text.trim(),
    )
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "رقم الهوية/الإقامة او كلمةالسر غير صحيحه"  );
    }))
        .user;

    if (firebaseUser != null) {
      DatabaseReference driversRef =
          FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).once().then((driverKey) {
        final snap = driverKey.snapshot;
        if (snap.value != null) {
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login Successful.");
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => MainScreen()));
        } else {
          Fluttertoast.showToast(msg: "No record exist with this email.");
          fAuth.signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => const MySplashScreen()));
        }
      });
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred during Login.");
    }
  }

  @override
 @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF85BBC2),
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 130, 0, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
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
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child: Image.asset(
                    'images/logo2.PNG',
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              TextField(
                controller: didTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "رقم الهوية/الإقامة",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "كلمة السر",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  validateForm();
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF85BBC2),
                ),
                child: const Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
              ),
             
            ],
          ),
        ),
        )
      ),
    );
  }
}
