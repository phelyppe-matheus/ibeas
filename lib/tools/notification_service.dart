import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:ibeas/classes/custom_notifications.dart';
import 'package:ibeas/routes.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setUpNotifications();
  }

  void _setUpNotifications() async {
    await _setUpTimezone();
    await _initializeNotifications();
  }

  _setUpTimezone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  _initializeNotifications() {
    const AndroidInitializationSettings android =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final DarwinInitializationSettings iOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    const LinuxInitializationSettings linux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: android,
      iOS: iOS,
      linux: linux,
    );
    localNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {}

  void _onDidReceiveNotificationResponse(NotificationResponse details) {
    if (details.payload != null && details.payload!.isNotEmpty) {
      Navigator.of(Routes.navigatorKey.currentState!.context)
          .pushReplacementNamed(details.payload ?? '/');
    }
  }

  showNotification(CustomNotification notification, {DateTime? schedule}) {
    schedule ??= DateTime.now().add(const Duration(seconds: 5));

    androidDetails = const AndroidNotificationDetails(
      "notifications ibeas",
      "lembretes ibeas",
      channelDescription: "Lembretes de eventos IBEAS",
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );

    if (schedule.isBefore(DateTime.now().add(Duration(minutes: 11)))) {
      localNotificationsPlugin.show(
        -2, 'Já passou o tempo', 'Verifique o horário do evento, já está na hora de ir ^-^', NotificationDetails(android: androidDetails));
      return;
    }

    localNotificationsPlugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      tz.TZDateTime.from(schedule, tz.local),
      NotificationDetails(android: androidDetails),
      payload: notification.payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  cancelNotification(int id) {
    localNotificationsPlugin.cancel(id);
  }

  checkForNotifications() async {
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onDidReceiveNotificationResponse(details.notificationResponse ??
          const NotificationResponse(
              notificationResponseType:
                  NotificationResponseType.selectedNotification));
    }
  }
}
