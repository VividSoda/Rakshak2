import 'dart:convert';

import 'package:flutter/services.dart';

// ignore: constant_identifier_names
const String _CONFIG_FILE_PATH = 'Assets/Config/config.json';

Future <Map<String,dynamic>> loadConfigFile() async{
  String json = await rootBundle.loadString(_CONFIG_FILE_PATH);
  return jsonDecode(json) as Map<String,dynamic>;
}