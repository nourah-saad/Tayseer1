import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
setUpnotification() {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);
}

void onSelectNotification(String? payload) {
  if (payload != null) {
    // open
  }
}

Future showNotification(
    {required status, required driverName, required involvedName}) async {
  String title = 'Accident involvement';
  String body = status == 'ques'
      ? '$driverName is claimimng you had an accident, press to confirm or disconfirm'
      : 'Involvment has been $status';
  var AndroidDetails = AndroidNotificationDetails("Reminder", "Reminder",
      importance: Importance.high);
  var iOSDetails = IOSNotificationDetails();
  var notificationDetails =
      NotificationDetails(android: AndroidDetails, iOS: iOSDetails);
  flutterLocalNotificationsPlugin.show(
      Random().nextInt(32000), title, body, notificationDetails);
}
