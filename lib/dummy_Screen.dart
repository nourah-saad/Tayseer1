/*import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Dummy_Screen extends StatefulWidget {
  const Dummy_Screen({Key? key}) : super(key: key);

  @override
  _Dummy_ScreenState createState() => _Dummy_ScreenState();
}

class _Dummy_ScreenState extends State<Dummy_Screen> {
  final user = FirebaseAuth.instance.currentUser;
  final myController = TextEditingController();
  Map<dynamic, String> cardetails_map = Map<dynamic, String>();
  String name = "";
  String nationality = "";
  String email = "";
  String sex = "";
  String Password = "";
  String Phone = "";

  String did = "";
  String id = '';

  // final User user = FirebaseAuth.instance.currentUser;
  DatabaseReference driversRef =
      FirebaseDatabase.instance.ref().child("drivers");

  bool is_edit = false;

  Future<String> inputData() async {
    final String uid = user!.uid.toString();
    return uid;
  }

  Future<void> current_user() async {
    var current_id = user!.uid;
    print(current_id);
  }

  _updatevalue() {

    driversRef.child(user!.uid).update({
      "email": myController.text,
      // "did": did,
      // "id": user!.uid,
      // "name": name,
      // "nationality": nationality,
      // "password": Password,
      // "cardetails_map": cardetails_map,
      // "phone": Phone,
      // "sex": sex
    }).then((value) {

      var snackBar = const SnackBar(content: Text('data is update'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  FirebaseAuth fAuth = FirebaseAuth.instance;

  Future<void> resetEmailAddress(
      String newEmail, String oldEmail, String password) async {
    var authResult = await fAuth.signInWithEmailAndPassword(
        email: oldEmail, password: password);
    await authResult.user!.updateEmail(newEmail);
  }

  Future resetEmail(String newEmail) async {
    var message;

    user!
        .updateEmail(newEmail)
        .then(
          (value) => message = 'Success',
        )
        .catchError((onError) => message = 'error');
    return message;
  }

  void printFirebase() {
    driversRef.child(user!.uid).once().then((snapshot) {
      print('Data : ${snapshot.snapshot.value}');
      Map<dynamic, dynamic> data =
          snapshot.snapshot.value as Map<dynamic, dynamic>;
setState(() {
  print(data['nationality'].toString());
  print(data['did']);
  print(data['phone']);
  print(data['email']);
  print(data['sex']);

  name = data['name'];
  nationality = data['nationality'];
  did = data['did'];
  email = data['email'];
  sex = data['sex'];
});

      //cardetails_map = data['car_details'];

    });
  }

  Future<void> init() async {
    try {
      final counterSnapshot = await driversRef
          .child(user!.uid)
          .get()
          .then((value) => value.ref.get());
    } catch (err) {
      print(err);
    }
  }

  void user_data() {
    // driversRef!.child(user!.uid).once().then((value) {
    //   final data=new Map<dynamic,dynamic>.from(value.snapshot.value);
    // });
    final uu = user!.uid.toString();
    driversRef.child(uu).onValue.listen((event) {
      Map<dynamic, dynamic> data =
          event.snapshot.value as Map<dynamic, dynamic>;
      final listh = data.values.single;
      print(listh.toString());
      data.forEach((key, value) {
        var dataa = value['did'].toString();

        // print(dataa);
      });
      //  final  name=event.snapshot.value;
      //print(name);
    });
  }

  @override
  void initState() {
    printFirebase();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //user_data();
    printFirebase();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              //  SingleChildScrollView(child:Container()),
              Container(
                  padding: EdgeInsets.all(25),
                  color: Color(0xff74BDC6),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: InkWell(
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black))),
                      Spacer(),
                      Container(
                        child: Text(
                          'تعديل الملف اشخصي',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Spacer(),
                    ],
                  )),
              Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: BoxDecoration(
                  color: Color(0xffD7ECED),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              is_edit = true;
                            });
                          },
                          child: Icon(
                            Icons.edit_outlined,
                            size: 30,
                          )),
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(20),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Column(
                      children: <Widget>[
                        // FutureBuilder(
                        //     future: data(),
                        //     builder: (context, sn) {
                        //   return Text("ii");
                        // }),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  child: Text(
                                '${name}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  child: new Text(
                                ':الإسم',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                          padding: EdgeInsets.only(right: 20, top: 10),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              is_edit == true
                                  ? Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: TextField(
                                          controller: myController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'البريد الإلكتروني الجديد',
                                          ),
                                          onChanged: (text) {
                                            setState(() {
                                              // fullName = text;
                                              //you can access nameController in its scope to get
                                              // the value of text entered as shown below
                                              //fullName = nameController.text;
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  : Container(
                                      child: Text(
                                      email,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    )),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  child: new Text(
                                ':البريد الإلكتروني',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                          padding: EdgeInsets.only(right: 20, top: 10),
                        ),

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  child: Text(
                                did,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  child: new Text(
                                ':رقم الهوية/ الإقامة',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                          padding: EdgeInsets.only(right: 20, top: 10),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  child: Text(
                                sex,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  child: new Text(
                                ':الجنس',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                          padding: EdgeInsets.only(right: 20, top: 10),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  child: Text(
                                    nationality,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  child: new Text(
                                    ':الجنسية',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                          padding: EdgeInsets.only(right: 20, top: 10),
                        ),
                        is_edit == true
                            ? Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        width: 100,
                                        child: ElevatedButton(
                                          child: Text("حفظ"),
                                          onPressed: () {
                                           //this function update realtime database
                                            _updatevalue();

                                            //this function update auth email

                                            resetEmailAddress(myController.text,
                                                email, Password);

                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                            onPrimary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                            ),
                                          ),
                                        )),
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        width: 100,
                                        child: ElevatedButton(
                                          child: Text("تراجع"),
                                          onPressed: () {
                                            setState(() {
                                              is_edit = false;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.green,
                                            onPrimary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/