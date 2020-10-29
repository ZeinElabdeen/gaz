import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/AwsomeDialog.dart';
import 'package:master/Helpers/app_theme.dart';

Widget visitorScreen(BuildContext context) {
  return InkWell(
    onTap: () {
      visitorDialog(context);
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            "assets/icons/logo.png",
            width: MediaQuery.of(context).size.width * .6,
            height: MediaQuery.of(context).size.width * .6,
          ),
          Text(
            translator.currentLanguage == "en"
                ? "Please login firstly"
                : "قم بتسجيل الدخول أولا",
            style: TextStyle(
                color: AppTheme.rejectButtonColor,
                fontSize: 14,
                fontWeight: FontWeight.w800),
          ),
          Text(
            translator.currentLanguage == "en"
                ? "Go to login Screen"
                : "الذهاب لتسجيل الدخول",
            style: TextStyle(
                color: AppTheme.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    ),
  );
}
