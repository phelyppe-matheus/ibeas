import 'package:flutter/material.dart';

import 'package:ibeas/pages/congress_list.dart';
import 'package:ibeas/pages/event_detail.dart';
import 'package:ibeas/pages/event_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
}