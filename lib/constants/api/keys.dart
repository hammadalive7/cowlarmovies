
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Key {
  static String apiKey = dotenv.env['APIKEY']!;
}
