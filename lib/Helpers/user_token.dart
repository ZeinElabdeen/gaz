import 'dart:io';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> headersMap() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  Map<String, dynamic> headersData = {
    'Authorization': preferences.getString("token"),
    //"lang": translator.currentLanguage,
    "Accept": "application/json"
  };
  return headersData;
}

Future<Map<String, dynamic>> headersMapWithFcm() async {
   Map<String, dynamic> headersData = {
      "lang": translator.currentLanguage,
    "Accept": "application/json",
     "os": Platform.isAndroid ? "android" : "ios",

  };
  return headersData;
}

Future<Map<String, dynamic>> headersMapWithoutToken() async {
  // SharedPreferences preferences = await SharedPreferences.getInstance();
  Map<String, dynamic> headersData = {
    // 'Authorization': preferences.getString("token"),
    //   "lang": translator.currentLanguage,
    "Accept": "application/json"
  };
  return headersData;
}
