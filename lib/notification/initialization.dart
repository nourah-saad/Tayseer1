import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:tayseer2/navigationService.dart';

import '../confirmation_page/confirmation_page.dart';

var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
setUpnotification() async {
  var androidInitilize = AndroidInitializationSettings('@mipmap/ic_launcher');
  var iOSinitilize = IOSInitializationSettings();
  var initilizationsSettings =
      InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
  flutterLocalNotificationsPlugin.initialize(initilizationsSettings,
      onSelectNotification:
          clicked /*(payload) async {
      if (payload != null) {
        print('clicked payl $payload');
        await navigator!.push<void>(
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                ConfirmationPageWidget(accidentID: payload),
          ),
        );
      } else {
        print('not clicked');
      }
    },*/
      );
}

Future<void> clicked(String? payload) async {
  if (payload != null) {
    print('not null $payload');
    await Navigator.push(
        navigationService.navigatorKey.currentContext!,
        MaterialPageRoute(
            builder: (context) => ConfirmationPageWidget(accidentID: payload)));
  } else {
    print('whhhyyy null');
  }
}

Future showNotification(
    {required status,
    required driverName,
    required involvedName,
    required payload}) async {
  String title = 'تأكيد الحادث';
  String body = status == 'ques'
      ? 'يرجى النقر لتأكيد انضمامك في حادث مروري أو الرفض '
      : 'Involvment has been $status';
  var AndroidDetails =
      AndroidNotificationDetails("", "", importance: Importance.high);
  var iOSDetails = IOSNotificationDetails();
  var notificationDetails =
      NotificationDetails(android: AndroidDetails, iOS: iOSDetails);
  flutterLocalNotificationsPlugin.show(
      Random().nextInt(32000), title, body, notificationDetails,
      payload: payload);
}
