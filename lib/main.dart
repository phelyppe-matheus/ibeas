import 'package:flutter/material.dart';
import 'package:ibeas/classes/custom_notifications.dart';

import 'package:ibeas/pages/congress_list.dart';
import 'package:ibeas/pages/event_detail.dart';
import 'package:ibeas/pages/event_list.dart';
import 'package:ibeas/tools/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationService>(
            create: (context) => NotificationService()),
      ],
      child: const IbeasApp(),
    ),
  );
}

class IbeasApp extends StatefulWidget {
  const IbeasApp({super.key});

  @override
  State<IbeasApp> createState() => _IbeasAppState();
}

class _IbeasAppState extends State<IbeasApp> {
  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
      notifyUser();
    });
    super.initState();
    checkNotifications();
  }

  void checkNotifications() async {
    await Provider.of<NotificationService>(context, listen: false)
        .checkForNotifications();
  }

  void notifyUser() async {
    bool? notified = sharedPreferences.getBool("notifyUser");

    if (notified == null) {
      Provider.of<NotificationService>(context, listen: false).showNotification(
        CustomNotification(
            -1,
            "Notificações",
            "Ative o sininho dos eventos para receber um lembrete de 10 min de antecedência",
            "/"),
      );
      sharedPreferences.setBool("notifyUser", true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: CongressList.routeName,
      routes: {
        CongressList.routeName: (context) => const CongressList(),
        EventList.routeName: (context) => const EventList(),
        EventDetail.routeName: (context) => const EventDetail()
      },
    );
  }
}
/* 
class IbeasApp extends StatelessWidget {
  const IbeasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: CongressList.routeName,
      routes: {
        CongressList.routeName: (context) => const CongressList(),
        EventList.routeName: (context) => const EventList(),
        EventDetail.routeName:(context) => const EventDetail()
      },
    );
  }
} */