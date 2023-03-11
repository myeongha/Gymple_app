import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotification {
  LocalNotification._();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static initialize() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings("mipmap/ic_main");

    InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> bookNotification(int bookHour) async {
    tz.initializeTimeZones();
    final now = DateTime.now();
    final specificTime = TimeOfDay(hour: bookHour-1, minute: 30);
    final tzDateTime = tz.TZDateTime(
        tz.getLocation("Asia/Seoul"),
        now.year,
        now.month,
        now.day,
        specificTime.hour,
        specificTime.minute);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails("channelId", "channelName",
        channelDescription: "channel description",
        importance: Importance.max,
        priority: Priority.max,
        showWhen: true);
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0, "짐플", "곧 운동 가실 시간이에요!",
        tzDateTime, platformChannelSpecifics,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  static Future<void> cancelNotification() async{
    await flutterLocalNotificationsPlugin.cancel(0);
  }
}