import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:scavis/gui/2-main-menu/main-menu.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MyNotification {
  BuildContext context;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  MyNotification(this.context) {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  // request the permission to display notifications
  void requestIOSPermission() {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>().requestPermissions(
          alert: false,
          badge: true,
          sound: true,
        );
  }

  // start the notification
  void initNotification() async {
    var initializationSettingsAndroid = AndroidInitializationSettings('notification_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        
      },
    );
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String payload) async {
      
    });
  }

  Future<void> showWeeklyAtDayTime(int notificationId, int weekday, Time time) async {
    // set the time zone
    await _configureLocalTimeZone();

    var androidChannelSpecifics = AndroidNotificationDetails(
      "ALBA (BAT) Notification",
      "ALBA (BAT) Channel",
      "ALBA (BAT) Description",
      importance: Importance.max,
      priority: Priority.high,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var notificationDetails = NotificationDetails(android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      "Hinweis",
      "Zeit für Ihre Atemübungen",
      _nextInstanceOfWeekdayAndTime(weekday, time),
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: '',
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime
    );
  }

  Future<void> createNotification(int notificationId, DateTime dt, String title, String body) async {
    // set the time zone
    await _configureLocalTimeZone();

    var androidChannelSpecifics = AndroidNotificationDetails(
      "scavis Notification",
      "scavis Channel",
      "scavis Description",
      importance: Importance.max,
      priority: Priority.high,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var notificationDetails = NotificationDetails(android: androidChannelSpecifics, iOS: iosChannelSpecifics);

    tz.initializeTimeZones();
    String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.TZDateTime tzDt = tz.TZDateTime.from(dt, tz.getLocation(timeZoneName));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      title,
      body,
      tzDt,
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: '',
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime
    );
  }

  // configure the datetime to use the phone's time zone
  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  // get the next date with the specified weekday and time
  tz.TZDateTime _nextInstanceOfWeekdayAndTime(int weekday, Time time) {
    // get local timezone
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    // go to the next date/time with the defined time
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    // go to the next date with the defined weekday
    while (scheduledDate.weekday != weekday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  // cancel a notification
  Future<void> cancelNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  // select notification is called when a notification was clicked in the status bar
  Future selectNotification(String payload) async {
    if (payload != null) {}
    Navigator.pushReplacementNamed(context, MainMenuScreen.ROUTE);
  }
}