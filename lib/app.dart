import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'Helpers/app_theme.dart';
import 'package:google_map_location_picker/generated/i18n.dart'
    as location_picker;

import 'Screens/Mutual/splashViw/SplashView.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.cupertino,
      popGesture: Get.isPopGestureEnable,
      smartManagement: SmartManagement.full,
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        location_picker.S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      locale: translator.locale,
      supportedLocales: translator.locals(),
      home: SplashView(),
      title: "Gas",
      theme: ThemeData(
          fontFamily: 'JF-Flat',
          backgroundColor: AppTheme.backGroundColor,
          primaryColor: AppTheme.primaryColor,
          accentColor: AppTheme.secondaryColor),
    );
  }
}
