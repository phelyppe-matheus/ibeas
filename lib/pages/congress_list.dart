import 'package:flutter/material.dart';
import 'package:ibeas/classes/congress.dart';
import 'package:ibeas/data/get_congress.dart';
import 'package:ibeas/pages/event_list.dart';

class CongressList extends StatelessWidget {
  static var routeName = '/CongressList';

  const CongressList({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarTextStyle: const TextStyle(color: Color(0xFF2A2BC3)),
          titleTextStyle: const TextStyle(color: Color(0xFF2A2BC3)),
          iconTheme: const IconThemeData(color: Color(0xFF2A2BC3)),
          backgroundColor: const Color(0xFFF0F4F4),
          title: const Text('Congressos'),
        ),
        body: const CongressListBody(),
      ),
    );
  }
}

class CongressListBody extends StatefulWidget {
  const CongressListBody({super.key});

  @override
  State<CongressListBody> createState() => _CongressListBodyState();
}

class _CongressListBodyState extends State<CongressListBody> {
  final List<Congress> _congressos = [];

  @override
  void initState() {
    super.initState();
    GetRetoolApiCongress()(1, congressImagePath: 'assets/logo_congea.png')
        .then((value) {
      setState(() {
        _congressos.add(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _congressos.length,
      itemBuilder: (context, index) => _congressItem(_congressos[index]),
    );
  }

  ListTile _congressItem(Congress congress) {
    return ListTile(
      title: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, EventList.routeName,
              arguments: EventListArguments(congress: congress));
        },
        child: Image(
          image: AssetImage(congress.congressImagePath),
        ),
      ),
      trailing: SizedBox(
        height: double.infinity,
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: IconButton(
            icon: Icon(congress.followed
                ? Icons.notifications
                : Icons.notifications_outlined),
            onPressed: () {
              setState(() {
                congress.followed = !congress.followed;
              });
            },
          ),
        ),
      ),
      contentPadding: const EdgeInsets.all(8.0),
    );
  }
}
