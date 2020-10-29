import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Screens/Mutual/splashViw/SplashView.dart';

AwesomeDialog visitorDialog(BuildContext context) {
  return AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: translator.currentLanguage == "en"
          ? "Please login firstly"
          : "قم بتسجيل الدخول أولا",
      desc: translator.currentLanguage == "en"
          ? "Go to login page ?"
          : "هل تريد الذهاب لتسجيل الدخول ؟",
      dismissOnTouchOutside: true,
      btnOkText: translator.currentLanguage == "en" ? "Accept" : "موافق",
      btnCancelText: translator.currentLanguage == "en" ? "Cancel" : "رفض",
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Get.offAll(
          SplashView(),
        );
      })
    ..show();
}
