import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tayseer2/notification/notification.dart';

proccessAcc(
    {required accID,
    required driverID,
    required involvedID,
    required status}) async {
  DateTime accTime = await getTime(accID);
  GeoPoint accLocation = await getAccLocation(accID);
  // driver locations
  List<List> driverResult = await getLocation(driverID, accTime, []);
  List<double> driverlocations = driverResult[0] as List<double>;
  List<DateTime> timeIntervals = driverResult[1] as List<DateTime>;

  //involved driver locations
  List<List> invlovedResult =
      await getLocation(involvedID, accTime, timeIntervals);
  List<double> involvedLocations = invlovedResult[0] as List<double>;
  print('size is ${driverlocations.length}');
  print('size is ${involvedLocations.length}');
  for (int i = 0; i < driverlocations.length; i++) {
    print(
        'location $i in driverlocations of $driverID is ${driverlocations[i]}');
  }
  print('size is ${involvedLocations.length}');
  for (int i = 0; i < involvedLocations.length; i++) {
    print('location $i in involvedLocations is ${involvedLocations[i]}');
  }

  print('size dr is ${timeIntervals.length}');
  print('size in is ${(invlovedResult[1] as List<DateTime>).length}');
  for (int i = 0; i < timeIntervals.length; i++) {
    print('time $i in timesInterval of driver is ${timeIntervals[i]}');
  }
  print('size is ${(invlovedResult[1] as List<DateTime>).length}');
  for (int i = 0; i < (invlovedResult[1] as List<DateTime>).length; i++) {
    print('time $i in timesInterval of involved is ${timeIntervals[i]}');
  }

//proccess
  proccessGuiltiness(driverlocations, involvedLocations, driverID, involvedID,
      accID, status, accLocation, accTime);
}

getLocation(String driverID, DateTime accTime, List<DateTime> times) async {
  List<List> result = [];
  List<DateTime> timeIntervals = [];
  List<double> locations = [];
  int start = times.isEmpty ? 9 : times.length - 1;
  print('kkjj $start');
  for (int i = start; i >= 0; i--) {
    await FirebaseFirestore.instance
        .collection('Tracking')
        .doc(driverID)
        .collection('locations')
        .where('time',
            isGreaterThanOrEqualTo: times.isEmpty
                ? accTime.subtract(Duration(seconds: 6 * i))
                : times[i])
        .where('time',
            isLessThan: times.isEmpty || i == times.length - 1
                ? accTime.add(Duration(milliseconds: 1))
                : times[i + 1])
        .limit(1)
        .get()
        .then((value) {
      print('iteratioj $i');
      value.docs.forEach((element) {
        print('entered');
        if (timeIntervals.isEmpty ||
            !timeIntervals
                .contains((element.data()['time'] as Timestamp).toDate())) {
          timeIntervals.add((element.data()['time'] as Timestamp).toDate());
          print('time added ${(element.data()['time'] as Timestamp).toDate()}');
          locations.add(element.data()['lat']);
          print(
              'id= ${element.reference.id} added, value= ${element.data()['lat']} drriver $driverID in $i');
        }
      });
    });
  }
  if (times.isNotEmpty) {
    locations = locations.reversed.toList();
  }
  result.add(locations);

  result.add(timeIntervals);

  return result;
}

proccessGuiltiness(driverlocations, involvedLocations, driverID, involvedID,
    accID, status, accLocation, accTime) {
  String guilty = 'غير محدد', accType = 'خارج نطاق التطبيق';
  // driver behavior
  String driverBehavior = getBehavior(driverlocations);
  print('driver behavior is $driverBehavior');

  //involved behavior
  String involvedBehavior = getBehavior(involvedLocations);
  print('indriver behavior is $involvedBehavior');

  //proccess
  if (driverBehavior == 'Circle') {
    guilty = driverID;
    accType = 'drift';
  } else if (involvedBehavior == 'Circle') {
    guilty = involvedID;
    accType = 'drift';
  } else if (involvedBehavior == driverBehavior) {
    switch (driverBehavior) {
      case 'StraightF':
        accType = 'S1';
        if (driverlocations[0] < involvedLocations[0]) {
          guilty = driverID;
        } else {
          guilty = involvedID;
        }
        break;
      case 'StraightB':
        accType = 'S1';
        if (driverlocations[0] > involvedLocations[0]) {
          guilty = driverID;
        } else {
          guilty = involvedID;
        }
        break;
    }
  }
  print('guilty driver is $guilty');
  updateReport(accID, guilty, driverID, involvedID, accType, status,
      accLocation, accTime);
}

String getBehavior(List<double> driverlocations) {
  int countF = 0, countB = 0;

  for (int i = 0; i < driverlocations.length - 1; i++) {
    if (driverlocations[i] <= driverlocations[i + 1])
      countF++;
    else
      countB++;
  }
  if (countF == driverlocations.length - 1) {
    return 'StraightF';
  } else if (countB == driverlocations.length - 1) {
    return "StraightB";
  } else {
    return "Circle";
  }
}

Future<void> updateReport(accID, String guilty, driverID, involvedID,
    String accType, status, accLocation, accTime) async {
  await FirebaseFirestore.instance.collection('Accident').doc(accID).update({
    'Fault_assessment': FieldValue.arrayUnion([
      guilty == 'غير محدد'
          ? 'غير محدد'
          : guilty == driverID
              ? '%100'
              : '%0',
      guilty == 'غير محدد'
          ? '.غير محدد'
          : guilty == involvedID
              ? '%100'
              : '%0',
    ]),
    'accident_type': accType,
    'status': guilty == 'غير محدد' ? 'خارج نطاق التطبيق' : status
  }).then((value) {
    String type = guilty == 'غير محدد' ? 'خارج نطاق التطبيق' : 'completed';
    sendCompletedNotification(driverID, accID, accLocation, accTime, type);
    sendCompletedNotification(involvedID, accID, accLocation, accTime, type);
    update(status: status, id: driverID, accID: accID);
    update(status: status, id: involvedID, accID: accID);
  });
}

sendCompletedNotification(id, accID, accLocation, accTime, type) {
  sendNotification(
      receiver: id,
      title: 'تقرير الحادث',
      msg: 'تم اكتمال تقرير الحادث',
      accID: accID,
      sender: id,
      type: type,
      accLocation: accLocation,
      accTime: accTime);
}

update({required status, required id, required accID}) {
  FirebaseFirestore.instance
      .collection('Driver')
      .doc(id)
      .collection('Notifications')
      .where('Accident_id', isEqualTo: accID)
      .get()
      .then((value) => value.docs.forEach((element) {
            element.reference.update({'status': status});
          }));
}

getAccLocation(accID) async {
  GeoPoint location = await FirebaseFirestore.instance
      .collection('Accident')
      .doc(accID)
      .get()
      .then((value) => (value.data()!['Location'] as GeoPoint));

  return location;
}

getTime(accID) async {
  DateTime time = await FirebaseFirestore.instance
      .collection('Accident')
      .doc(accID)
      .get()
      .then((value) => (value.data()!['Date_time'] as Timestamp).toDate());

  return time;
}
