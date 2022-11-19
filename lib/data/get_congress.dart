// 
// https://retoolapi.dev/LyeAr8/ibeas

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:ibeas/classes/congress.dart';
import 'package:ibeas/models/congress_retool_api.dart';

class GetRetoolApiCongress {
  Future<Congress> call(int congress, {required String congressImagePath}) async {
    http.Response data = await http.get(Uri.parse('https://retoolapi.dev/LyeAr8/ibeas?congress=$congress'));

    return RetoolApiCongress.fromJson(congressImagePath, jsonDecode(data.body));
  }
}
