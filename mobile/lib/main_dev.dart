import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_archery/core/services/MyHttpOverrides.dart';
import 'package:my_archery/main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  HttpOverrides.global = new MyHttpOverrides();
  await dotenv.load(fileName: ".env.development");
  runApp(MyApp());
}