import 'package:flutter/material.dart';
import 'package:ibeas/pages/congress_list.dart';
import 'package:ibeas/pages/event_detail.dart';
import 'package:ibeas/pages/event_list.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder>{
    CongressList.routeName: (context) => const CongressList(),
        EventList.routeName: (context) => const EventList(),
        EventDetail.routeName:(context) => const EventDetail(),
  };

  static String initial = CongressList.routeName;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}