


import 'package:flutter/material.dart';
import 'package:lot_to_do/first_screen.dart';
import 'package:lot_to_do/add_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lot_to_do/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:alarm/alarm.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;



Stream<List<User>> readUsers() {
  return FirebaseFirestore.instance.collection('details').snapshots().map(
          (snapshot) =>
          snapshot.docs.map(
                  (doc)
              =>User.fromJson(doc.data())

          ).toList());
}




DateTime func(String date, String time) {
  // Split the date string into year, month, and day components
  List<int> dateParts = date.split('-').map(int.parse).toList();

  // Split the time string into hours and minutes
  List<int> timeParts = time.split(':').map(int.parse).toList();

  // Create a DateTime object by providing year, month, day, hour, and minute
  DateTime dateTime = DateTime(
    dateParts[0], // Year
    dateParts[1], // Month
    dateParts[2], // Day
    timeParts[0], // Hour
    timeParts[1], // Minute
  );

  return dateTime;
}





class Notify {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
  AndroidInitializationSettings( 'note'); // You should specify an icon for the notifications.


  Future<void> initializeNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
    );
  }
  NotificationDetails notificationDetails(){
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',importance: Importance.max,)
    );
  }
  Future<void> sendNotification({int id=0,String? title, String ?body,String?  payload}) async {

    return _flutterLocalNotificationsPlugin.show(
      0, // Notification ID, you can customize it.
      title,
      body,
      await notificationDetails(),
    );
  }

  Future<dynamic> scheduleNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduled})

  async {
    return _flutterLocalNotificationsPlugin.zonedSchedule(
        id, title, body,tz.TZDateTime.from(scheduled,tz.local), await notificationDetails(), uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,androidAllowWhileIdle:true );

  }
}




