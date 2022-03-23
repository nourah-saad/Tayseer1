import 'package:firebase_database/firebase_database.dart';

class DriverModel {
  String? id;
  String? did;
  String? email;
  String? name;
  String? nationality;
  String? phone;
  String? sex;

  DriverModel({
    this.id,
    this.did,
    this.email,
    this.name,
    this.nationality,
    this.phone,
    this.sex,
  });

  DriverModel.fromSnapshot(DataSnapshot snap) {
    id = snap.key;
    did = (snap.value as dynamic)["Driver_Id"];
    email = (snap.value as dynamic)["email"];
    name = (snap.value as dynamic)["name"];
    nationality = (snap.value as dynamic)["nationality"];
    phone = (snap.value as dynamic)["phone"];
    sex = (snap.value as dynamic)["sex"];
  }
}
