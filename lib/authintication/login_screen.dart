import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tayseer2/global/global.dart';
import 'package:tayseer2/mainScreen/main_screen.dart';
import 'package:tayseer2/widgets/progress_dialog.dart';
import '../Driver/getters.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool ishiddenPassword = true;
  TextEditingController didTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  late bool passwordVisibility = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final CollectionReference driversRefc =
      FirebaseFirestore.instance.collection('Driver');
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
    await FirebaseAuth.instance.signInAnonymously();
    String dEmail = await getEmail(didTextEditingController.text.trim());
    await FirebaseAuth.instance.signOut();
    print('gotten email $dEmail');
    User? firebaseUser;
    try {
      firebaseUser = (await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: dEmail,
              password: passwordTextEditingController.text.trim()))
          .user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
        case 'Error 17011':
        case 'wrong-password':
        case 'Error 17009':
        case 'invalid-email':
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "رقم الهوية/الإقامة أو كلمة السر غير صحيحة");
          break;
        default:
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "فضلا تأكد من اتصالك بالإنترنت");
      }
    } catch (e) {
      return e.toString();
    }
    /*final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
      email: dEmail,
      password: passwordTextEditingController.text.trim(),
    )
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "رقم الهوية/الإقامة أو كلمةالسر غير صحيحة");
    }))
        .user;*/

    if (firebaseUser != null) {
      driversRefc.doc(firebaseUser.uid).get().then((driverKey) {
        final snap = driverKey.exists;
        if (snap != null) {
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "تم تسجيل الدخول بنجاح");
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => MainScreen()));
        } /* else {
          Fluttertoast.showToast(msg: "No record exist with this email.");
          fAuth.signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => const MySplashScreen()));
        }*/
      });
    } /*else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred during Login.");
    }*/
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
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: Image.asset(
                        'images/logo2.PNG',
                        width: MediaQuery.of(context).size.width * 1.9,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 230, bottom: 13, top: 0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: '*',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              )),
                          TextSpan(
                              text: 'رقم الهوية/الإقامة',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF46494D),
                              )),
                        ]),
                      ),
                    ),
                    TextField(
                      controller: didTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(90, 133, 187, 194),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(90, 133, 187, 194)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 280, bottom: 13, top: 0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: '*',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              )),
                          TextSpan(
                              text: 'كلمة المرور',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF46494D),
                              )),
                        ]),
                      ),
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      keyboardType: TextInputType.text,
                      obscureText: ishiddenPassword,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(90, 133, 187, 194),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
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
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/images/tayseer.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
