import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment{
  static String get apiUrl => dotenv.env['API_URL'] ?? 'https://api.myarchery.id';
  static String get webUrl => dotenv.env['WEB_URL'] ?? 'https://myarchery.id';
  static String get urlMidtransSnap => dotenv.env['URL_MIDTRANS_SNAP'] ?? 'https://app.midtrans.com/snap/v2/vtweb/';
  static String get placesApiKey => dotenv.env['PLACES_API_KEY'] ?? '';
}