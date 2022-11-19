import 'package:ibeas/classes/congress.dart';

class Event {
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

  Event({
    required this.congresso, required this.dia, required this.abertura, required this.fechamento, required this.evento, required this.tituloEvento, required this.descricao, required this.autoridade, required this.titulo, required this.localEvento,});
}