import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Model_user.dart';

//import 'Model_user.dart';

class User_servies{
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference driversRef =
  FirebaseFirestore.instance.collection('Driver');


  Future<UserModel> getUser() async {
    try {
      var uid = user!.uid;
      DocumentSnapshot _doc =
      await driversRef.doc(uid).get();

      return UserModel.fromDocumentSnapshot(snapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<dynamic>user_Account_update(String email) async{

    var uid = user!.uid;
    return  await driversRef.doc(uid).update({'email':email});

  }
}