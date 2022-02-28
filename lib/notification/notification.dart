import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tayseer2/confirmation_loading_page/confirmed.dart';
import 'package:tayseer2/navigationService.dart';
import 'package:http/http.dart' as http;

import '../confirmation_page/confirmation_page.dart';

CollectionReference<Map<String, dynamic>> driverCollection =
    FirebaseFirestore.instance.collection('Driver');
CollectionReference<Map<String, dynamic>> accidentCollection =
    FirebaseFirestore.instance.collection('Accident');
User user = FirebaseAuth.instance.currentUser!;

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
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    print('mmmmyy ${message.data['type']}');
    if (notification != null && android != null && !kIsWeb) {
      switch (message.data['type']) {
        case 'ques':
          Navigator.push(
              navigationService.navigatorKey.currentContext!,
              MaterialPageRoute(
                  builder: (context) => ConfirmationPageWidget(
                        accidentID: '${message.data['accID']}',
                        sender: message.data['sender'],
                      )));
          break;

        case 'accept':
        case 'denied':
          Navigator.pushReplacement(
              navigationService.navigatorKey.currentContext!,
              MaterialPageRoute(
                  builder: (context) => ConfirmedPage(
                        status: message.data['type'],
                      )));
          break;
      }
    }
  });

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessageOpenedApp.listen(notificationPressed);

  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    Navigator.push(
        navigationService.navigatorKey.currentContext!,
        MaterialPageRoute(
            builder: (context) => ConfirmationPageWidget(
                  accidentID: '${initialMessage.data['accID']}',
                  sender: initialMessage.data['sender'],
                )));
  }
}

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
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
  print('my data${message.data['accID']}');
  Navigator.push(
      navigationService.navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => ConfirmationPageWidget(
                accidentID: '${message.data['accID']}',
                sender: message.data['sender'],
              )));
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
