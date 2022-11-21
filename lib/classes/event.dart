import 'dart:convert';

import 'package:ibeas/classes/congress.dart';

class Event {
  final int id;
  final Congress congresso;
  final DateTime dia;
  final DateTime abertura;
  final DateTime fechamento;
  final String evento;
  final String tituloEvento;
  final String descricao;
  final String autoridade;
  final String titulo;
  final String localEvento;

  bool followed = false;

  Event({
    required this.id,
    required this.congresso,
    required this.dia,
    required this.abertura,
    required this.fechamento,
    required this.evento,
    required this.tituloEvento,
    required this.descricao,
    required this.autoridade,
    required this.titulo,
    required this.localEvento,
  });

  String get toJson => jsonEncode(
        toMap,
      );

  Map<String, Object> get toMap => {
        'id': id,
        'congresso': congresso,
        'dia': dia,
        'abertura': abertura,
        'fechamento': fechamento,
        'evento': evento,
        'tituloEvento': tituloEvento,
        'descricao': descricao,
        'autoridade': autoridade,
        'titulo': titulo,
        'localEvento': localEvento,
      };
}
