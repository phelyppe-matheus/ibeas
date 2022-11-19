import 'package:ibeas/classes/congress.dart';
import 'package:ibeas/classes/event.dart';

class RetoolAPIEvent extends Event {
  RetoolAPIEvent({
    required super.congresso,
    required super.dia,
    required super.abertura,
    required super.fechamento,
    required super.evento,
    required super.tituloEvento,
    required super.descricao,
    required super.autoridade,
    required super.titulo,
    required super.localEvento,
  });

  factory RetoolAPIEvent.fromJson(Map<String, dynamic> json, Congress congress)
  {
    var date = json["dia"].toString().split('/').reversed.join('-');
    var abertura = '${date}T${json["abertura"]}:00';
    var fechamento = '${date}T${json["fechamento"]}:00';

    return RetoolAPIEvent(
      dia: DateTime.parse(date),
      evento: json["evento"],
      titulo: json["titulo"],
      abertura: DateTime.parse(abertura),
      congresso: congress,
      descricao: json["descricao"],
      autoridade: json["autoridade"],
      fechamento: DateTime.parse(fechamento),
      localEvento: json["local_evento"],
      tituloEvento: json["titulo_evento"],
    );
  }
}
