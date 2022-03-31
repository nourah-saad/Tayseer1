import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tayseer2/navigationService.dart';
import 'package:http/http.dart' as http;

import '../report_an_accident/confirmation/confirmation_page.dart';
import '../report_an_accident/confirmation/confirmed.dart';
import '../report_an_accident/select_your_car.dart';

CollectionReference<Map<String, dynamic>> driverCollection =
    FirebaseFirestore.instance.collection('Driver');
CollectionReference<Map<String, dynamic>> accidentCollection =
    FirebaseFirestore.instance.collection('Accident');
User user = FirebaseAuth.instance.currentUser!;
String messageID = '';

late AndroidNotificationChannel channel;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: false,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

setToken() {
  FirebaseMessaging.instance.getToken().then((value) {
    print('token $value');
    driverCollection.doc(user.uid).get().then((values) => {
          values.reference.update({'token': value})
        });
  });
}

loadFCM() async {
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'Tayseer notifications', // title
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: false,
    );
  }
}

listenFCM() async {
  // clicked when terminated
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null && messageID != message.messageId) {
      print('terminated entered');
      messageID = message.messageId!;
      redirect(message);
    }
  });

  //foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      redirect(message);
    }
  });
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  // app open in back
  FirebaseMessaging.onMessageOpenedApp.listen(notificationPressed);
}

Future<void> _messageHandler(RemoteMessage message) async {
  print('handler entered');
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    show(notification);
  }
}

show(notification) {
  flutterLocalNotificationsPlugin.show(
    notification.hashCode,
    notification.title,
    notification.body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
      ),
    ),
  );
}

void notificationPressed(RemoteMessage message) {
  print('onpressed entered');
  if (messageID != message.messageId) {
    messageID = message.messageId!;
    print('message id : $messageID');
    redirect(message);
  }
}

var postUrl = "https://fcm.googleapis.com/fcm/send";

Future<void> sendNotification(
    {required receiver,
    required title,
    required msg,
    required accID,
    required sender,
    required type}) async {
  String token = await getRecieverToken(receiver);
  print('token : $token');

  try {
    await http.post(
      Uri.parse(postUrl),
      headers: <String, String>{
        'content-type': 'application/json',
        'Authorization':
            'key=AAAA5je3a24:APA91bFalT97usz-l_5zLAYMxaPXvT7ao3fqjvT8M389pa9BE3qcBVSE_0hbxFpnFghIhha0G-1J9gRZzTt1t_zjYD_xtWUSthf-RxLCiEUKGb1o8YL1MhW5Mn5Ezoamiq8HFh_eUbj6'
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            "android_channel_id": 'high_importance_channel',
            'body': msg,
            'title': title,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'accID': '$accID',
            'sender': sender,
            'reciever': receiver,
            'type': '$type'
          },
          "to": token,
        },
      ),
    );
  } catch (e) {
    print("error push notification");
  }
}

Future<String> getRecieverToken(receiver) async {
  var token = await driverCollection.doc('$receiver').get().then((value) {
    print('foundy ${value.data()!['token']}');
    return '${value.data()!['token']}';
  });

  return token;
}

redirect(RemoteMessage message) {
  switch (message.data['type']) {
    case 'ques':
      Navigator.push(
          navigationService.navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => select_your_carWidget(
                  sender: message.data['sender'],
                  accID: message.data['accID'],
                  accTime: DateTime.parse('2000-01-01'),
                  accLocation: Position(
                      longitude: 0,
                      latitude: 0,
                      timestamp: DateTime.now(),
                      accuracy: 0,
                      altitude: 0,
                      heading: 0,
                      speed: 0,
                      speedAccuracy: 0))));
      break;

    case 'accept':
    case 'denied':
      Navigator.pushReplacement(
          navigationService.navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => ConfirmedPage(
                    status: message.data['type'],
                    sender: message.data['sender'],
                    reciever: message.data['reciever'],
                    accID: message.data['accID'],
                  )));
      break;
  }
}
