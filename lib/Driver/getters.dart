import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getName(String ID) async {
  print('ifd $ID');
  var name = await FirebaseFirestore.instance
      .collection('Driver')
      .doc('$ID')
      .get()
      .then((value) {
    return value.data()!['name'];
  });

  return name;
}

Future<String> getNatID(String ID) async {
  var nID = await FirebaseFirestore.instance
      .collection('Driver')
      .doc('$ID')
      .get()
      .then((value) {
    return value.data()!['Driver_Id'];
  });

  return nID;
}

Future<String> getEmail(id) async {
  var email = await FirebaseFirestore.instance
      .collection('Driver')
      .where('Driver_Id', isEqualTo: id)
      .get()
      .then((value) {
    if (value.size > 0) {
      return value.docs.first.data()['email'];
    } else
      return 'not';
  });

  return email;
}
