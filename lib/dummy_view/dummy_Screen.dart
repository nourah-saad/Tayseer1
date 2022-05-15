import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tayseer2/authintication/login_screen.dart';

import '../splashScreen/splash_screen.dart';
import 'Model_user.dart';
import 'User_servies.dart';

class EmailFieldValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "يرجى إدخال البريد الإلكتروني";
    }
    if (!value.contains('@')) {
      return "يرجى إدخال البريد الإلكتروني بشكل صحيح";
    } else {
      return "البريد الالكتروني";
    }
  }
}

class Dummy_Screen extends StatefulWidget {
  Dummy_Screen({controller_tab}) {
    tabcontroller = controller_tab;
  }

  @override
  _Dummy_ScreenState createState() => _Dummy_ScreenState();
}

TabController? tabcontroller;

class _Dummy_ScreenState extends State<Dummy_Screen> {
  final user = FirebaseAuth.instance.currentUser;
  final myController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final CollectionReference driversReff =
      FirebaseFirestore.instance.collection('Driver');
  UserModel _user = new UserModel(
      Email: '',
      Name: '',
      ID: '',
      did: '',
      Nationaltity: '',
      Password: '',
      phone: '',
      sex: '',
      user_ID: '');
  User_servies? user_servies;
  Map<dynamic, String> cardetails_map = Map<dynamic, String>();
  String name = "";
  String nationality = "";
  String email = "";
  String sex = "";
  String Password = "";
  String Phone = "";
  String did = "";
  String id = '';
  void load() async {
    user_servies = new User_servies();
    setState(() {});
    _user = await user_servies!.getUser();
  }

  // final User user = FirebaseAuth.instance.currentUser;
  final CollectionReference driversRefc =
      FirebaseFirestore.instance.collection('Driver');

  bool is_edit = false;

  Future<String> inputData() async {
    final String uid = user!.uid.toString();
    return uid;
  }

  dynamic data;

  Future<dynamic> getData() async {
    final DocumentReference document = driversRefc.doc(user!.uid);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {});
    });
  }

  Future<void> current_user() async {
    var current_id = user!.uid;
    print(current_id);
  }

  FirebaseAuth fAuth = FirebaseAuth.instance;

  Future<void> resetEmailAddress(
      String newEmail, String oldEmail, String password) async {
    var authResult = await fAuth.signInWithEmailAndPassword(
        email: oldEmail, password: password);
    await authResult.user!.updateEmail(newEmail);
  }

  Future<dynamic> user_Account_update(String email) async {
    print(email);
    var uid = user!.uid;
    return await driversReff.doc(uid).update({'email': email});
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

  // void printFirebase() {
  //   driversRef.child(user!.uid).once().then((snapshot) {
  //     print('Data : ${snapshot.snapshot.value}');
  //     Map<dynamic, dynamic> data =
  //         snapshot.snapshot.value as Map<dynamic, dynamic>;
  //     if (this.mounted) {
  //       setState(() {
  //         print(data['nationality'].toString());
  //         print(data['did']);
  //         print(data['phone']);
  //         print(data['email']);
  //         print(data['sex']);
  //
  //         name = data['name'];
  //         nationality = data['nationality'];
  //         did = data['did'];
  //         email = data['email'];
  //         sex = data['sex'];
  //
  //         // Your state change code goes here
  //       });
  //     }
  //
  //     //cardetails_map = data['car_details'];
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      getData();
      print(data);
      load();
      // printFirebase();

      print(_user.Name);
    });

    // TODO: implement initState
    super.initState();
  }

  void update_email(String _email) async {
    await user_servies!.user_Account_update(_email).then((value) {
      print('email upodate');
    });
  }

  @override
  Widget build(BuildContext context) {
    //user_data();
    //printFirebase();
    load();

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              //  SingleChildScrollView(child:Container()),
              Container(
                  padding: EdgeInsets.all(25),
                  color: Color(0xFF85BBC2),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                '${_user.Name}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  child: new Text(
                                ':الاسم',
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
                                        child: TextFormField(
                                          controller: myController,
                                          validator: (String? value) {
                                            bool emailValid = RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(myController.text);
                                            if (myController.text.isEmpty)
                                              return "يرجى إدخال بريد إلكتروني";
                                            if (emailValid != true)
                                              return "البريد الإلكتروني غير صحيح";
                                            else
                                              return null;
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText:
                                                '                      البريد الالكتروني الجديد             ',
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
                                      child: Flexible(
                                      child: Text(
                                        _user.Email!,
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
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
                                _user.did!,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  child: new Text(
                                ':رقم الهوية/الإقامة',
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
                                _user.sex!,
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
                                _user.Nationaltity!,
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
                                          child: Text(
                                            "حفظ",
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF46494D)),
                                          ),
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              //  String val;
                                              setState(() {
                                                // _updatevalue();

                                                user_Account_update(
                                                    myController.text);
                                                print('kamal' +
                                                    myController.text);
                                                //load();
                                                getData();
                                                myController.clear();
                                                is_edit = false;
                                              });
                                            }
                                            //this function update realtime database

                                            //this function update auth email

                                            // resetEmailAddress(myController.text,
                                            //     email, Password);
                                            // print();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(
                                                0xFF85BBC2), //const Color(0xFFEB6666),
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
                                          child: Text(
                                            "تراجع",
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF46494D)),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              is_edit = false;
                                              myController.clear();
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(
                                                0xffD7ECED), //Color.fromARGB(255, 191, 199, 199),// Colors.green,
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
                    Container(
                        padding: EdgeInsets.all(5),
                        width: 150,
                        child: ElevatedButton(
                          child: Text(
                            "تسجيل خروج",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF46494D)),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Color(0xffD7ECED),
                                title: Text(
                                  'تسجيل خروج',
                                  textAlign: TextAlign.right,
                                ),
                                content: Text(
                                  'هل أنت متأكد من تسجيل الخروج؟',
                                  textAlign: TextAlign.right,
                                ),
                                actions: [
                                  ElevatedButton(
                                    child: Text(
                                      "نعم",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF46494D)),
                                    ),
                                    onPressed: () {
                                      fAuth.signOut();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (c) => LoginScreen()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF85BBC2),
                                      onPrimary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    child: Text(
                                      "لا",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF46494D)),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xffD7ECED),
                                      onPrimary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFEB6666),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
