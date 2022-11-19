import 'package:flutter/material.dart';
import 'package:ibeas/classes/congress.dart';
import 'package:ibeas/classes/event.dart';
import 'package:timelines/timelines.dart';

class EventListArguments {
  final Congress congress;

  EventListArguments({required this.congress});
}

class EventList extends StatelessWidget {
  static var routeName = '/eventList';

  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarTextStyle: const TextStyle(color: Color(0xFF2A2BC3)),
          titleTextStyle: const TextStyle(color: Color(0xFF2A2BC3)),
          iconTheme: const IconThemeData(color: Color(0xFF2A2BC3)),
          backgroundColor: const Color(0xFFF0F4F4),
          title: const Text('Eventos'),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: const EventListBody(),
          ),
        ),
        backgroundColor: const Color(0xFFF0F4F4),
      ),
    );
  }
}

class EventListBody extends StatefulWidget {
  const EventListBody({super.key});

  @override
  State<EventListBody> createState() => _EventListBodyState();
}

class _EventListBodyState extends State<EventListBody> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as EventListArguments;

    Map<DateTime, List<Event>> eventsByDay = args.congress.toMapByDays;

    return Timeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        connectorTheme: const ConnectorThemeData(
          thickness: 3.0,
          color: Color(0xFF2A2BC3),
        ),
        indicatorTheme: const IndicatorThemeData(
          size: 15.0,
        ),
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: eventsByDay.length,
        contentsBuilder: (context, index) {
          return _eventDay(eventsByDay.values.toList()[index],
              eventsByDay.keys.toList()[index]);
        },
        indicatorBuilder: (_, index) {
          return const DotIndicator(
            position: 0,
            color: Color(0xFF2A2BC3),
          );
        },
        lastConnectorBuilder: (context) =>
            const DashedLineConnector(color: Color(0xFF2A2BC3)),
        firstConnectorBuilder: (context) =>
            const DashedLineConnector(color: Color(0xFF2A2BC3)),
        connectorBuilder: (_, index, ___) => const SolidLineConnector(
          color: Color(0xFF2A2BC3),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }

  Widget _eventDay(List<Event> mapByDay, DateTime date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
          child: Text(date.toIso8601String().split("T")[0]),
        ),
        Column(
          children: List<Widget>.generate(
              mapByDay.length, (index) => _eventTile(mapByDay[index])),
        ),
      ],
    );
  }

  Widget _eventTile(Event event) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: _eventCard(event),
        ),
        Positioned(
          top: -10,
          left: 20,
          child: Container(
            color: const Color(0xFFF0F4F4),
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Text(
              "${_formatDate(event.abertura)} - ${_formatDate(event.fechamento)}",
              style: const TextStyle(
                color: Color(0xFF4748EF),
                fontSize: 14,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          left: 20,
          child: Row(
            children: const [
              Icon(Icons.person, color: Color(0xFF4748EF)),
              Icon(Icons.person, color: Color(0xFF4748EF)),
              Icon(Icons.person, color: Color(0xFF4748EF)),
            ],
          ),
        ),
      ],
    );
  }

  Container _eventCard(Event event) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: const Color(0xFF2A2BC3),
          width: 1,
        ),
      ),
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          event.tituloEvento,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Color(0xFF2A2BC3),
                            fontSize: 19,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          event.localEvento.isNotEmpty
                              ? event.localEvento
                              : "Sem local predefinido",
                          style: const TextStyle(
                            color: Color(0xFF2A2BC3),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_outlined),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: double.infinity,
                child: Text(
                  event.descricao,
                  style: const TextStyle(
                    color: Color(0xFF2A2BC3),
                    fontSize: 19,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
