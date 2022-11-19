import 'package:flutter/material.dart';

class EventDetail extends StatelessWidget {
  static var routeName = '/eventDetail';

  const EventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const EventDetailBody(),
    );
  }
}

class EventDetailBody extends StatefulWidget {
  const EventDetailBody({super.key});

  @override
  State<EventDetailBody> createState() => _EventDetailBodyState();
}

class _EventDetailBodyState extends State<EventDetailBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
