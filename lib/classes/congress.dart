import 'package:ibeas/classes/event.dart';

class Congress {
  final String congressImagePath;
  late List<Event> events;

  bool followed;

  Congress({required this.congressImagePath, required this.followed});

  Map<DateTime, List<Event>> get toMapByDays {
    Map<DateTime, List<Event>> map = {};

    for (var event in events) {
      DateTime key = event.dia;
      map[key] != null ? map[key]?.add(event) : map[key] = [event];
    }

    var sortedByKeyMap = Map.fromEntries(
      map.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));

    return sortedByKeyMap;
  }
}
