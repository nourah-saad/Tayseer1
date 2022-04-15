import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tayseer2/notification/notification.dart';
import 'package:tayseer2/report_an_accident/confirmation/confirmation_page.dart';
import 'package:tayseer2/report_an_accident/select_your_car.dart';
import 'package:tayseer2/view_accidents/view_accident_report.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          SizedBox(
            height: 20,
            width: 200,
            child: Text('last'),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.85,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Driver')
                      .doc(user.uid)
                      .collection('Notifications')
                      .orderBy('Date_time', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('حدث خطأ، الرجاء المحاولة مرة أخرى');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: [
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'الرجاء الانتظار',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      );
                    } else {
                      final list = snapshot.data!.docs;
                      if (list.length == 0)
                        return Center(
                          child: Text("ليس لديك أي إشعارات"),
                        );
                      return Stack(children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () {
                                    print(
                                        'hrer is it ${list[index]['status']}');
                                    if (list[index]['status'] == 'مقبول' ||
                                        list[index]['status'] == 'مرفوض') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AccidentReportWidget(
                                                    id: list[index]
                                                        ['Accident_id'],
                                                  )));
                                    } else if (list[index]['status'] ==
                                            'added' &&
                                        list[index]['msg']
                                            .toString()
                                            .contains('يدعوك')) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => select_your_carWidget(
                                                  accTime: (list[index]['Date_time'] as Timestamp)
                                                      .toDate(),
                                                  add: false,
                                                  sender: list[index]['sender'],
                                                  accLocation: Position(
                                                      longitude: (list[index]
                                                                  ['Location']
                                                              as GeoPoint)
                                                          .longitude,
                                                      latitude: (list[index]
                                                                  ['Location']
                                                              as GeoPoint)
                                                          .latitude,
                                                      timestamp: (list[index]
                                                                  ['Date_time']
                                                              as Timestamp)
                                                          .toDate(),
                                                      accuracy: 0,
                                                      altitude: 0,
                                                      heading: 0,
                                                      speed: 0,
                                                      speedAccuracy: 0),
                                                  accID: list[index]['Accident_id'])));
                                    }
                                  },
                                  child: Card(
                                    elevation: 2,
                                    margin: EdgeInsets.all(4),
                                    color: Color.fromARGB(255, 207, 222, 224),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Color(0xFF85BBC2),
                                          child: Icon(
                                            Icons.notifications_sharp,
                                            color: Colors.white,
                                          )),
                                      title: Text(
                                        '${list[index]['title']}',
                                        textAlign: TextAlign.right,
                                      ),
                                      subtitle: Text('${list[index]['msg']}',
                                          textAlign: TextAlign.right),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ]);
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

addNotificationTolist(
    {required title,
    required msg,
    required recID,
    required sender,
    required accID,
    required accTime,
    required accLocation}) {
  FirebaseFirestore.instance
      .collection('Driver')
      .doc(recID)
      .collection('Notifications')
      .add({
    'title': title,
    'msg': msg,
    'sender': sender,
    'Accident_id': accID,
    'Date_time': accTime,
    'Location': accLocation,
    'status': 'added',
  });
}
