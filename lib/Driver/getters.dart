import 'package:cloud_firestore/cloud_firestore.dart';

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
