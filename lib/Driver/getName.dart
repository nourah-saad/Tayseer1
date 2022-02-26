import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getName(String ID) async {
  var name = await FirebaseFirestore.instance
      .collection('Driver')
      .doc('$ID')
      .get()
      .then((value) {
    return value.data()!['name'];
  });

  return name;
}
