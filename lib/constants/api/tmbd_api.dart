import 'dart:core';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'keys.dart';

class TMDbApi{
  static String baseUrl = dotenv.env['BASEURL']!;
  static String apiKey = Key.apiKey;
}