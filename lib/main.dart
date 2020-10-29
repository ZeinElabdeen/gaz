import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // LIST_OF_LANGS = ['ar', 'en'];
  // LANGS_DIR = 'assets/langs/';
  await translator
      .init(languagesList: ['ar', 'en'], assetsDirectory: 'assets/langs/');
  runApp(
    LocalizedApp(
      child: MyApp(),
    ),
  );
}
