import 'package:ibeas/classes/congress.dart';
import 'package:ibeas/models/event_retool_api.dart';

class RetoolApiCongress extends Congress {
  RetoolApiCongress({
    required super.congressImagePath,
    required super.followed,
  });

  RetoolApiCongress.fromJson(
    String congressImagePath,
    List<dynamic> json,
  ) : super(
          congressImagePath: congressImagePath,
          followed: false,
        ) {
          events = List.generate(
            json.length,
            (index) => RetoolAPIEvent.fromJson(json[index], this),
          );
        }
}
