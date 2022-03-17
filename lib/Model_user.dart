import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? did;
  String? Email;
  String? user_ID;
  String? ID;
  String? Name;
  String? Nationaltity;
  String? Password;
  String? phone;
  String? sex;

  UserModel(
      {this.did,
      this.Email,
      this.user_ID,
      this.ID,
      this.Name,
      this.Nationaltity,
      this.Password,
      this.phone,
      this.sex});


  UserModel.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    ID=snapshot.id;
    did=snapshot['did'];
    Email=snapshot['email'];
    user_ID=snapshot['id'];
    Name=snapshot['name'];
    Nationaltity=snapshot['nationality'];
    Password=snapshot['password'];
    phone=snapshot['phone'];
    sex=snapshot['sex'];
  }
}
