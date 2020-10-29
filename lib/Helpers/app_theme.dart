import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  AppTheme._();
  static Color primaryColor = Color(
    getColorHexFromStr("#21559A"),
  );
  static Color secondaryColor = Color(
    getColorHexFromStr("#B5B4B4"),
  );
  static Color accentColor = Color(
    getColorHexFromStr("#F47630"),
  );
  static Color thirdColor = Color(
    getColorHexFromStr("#F6F7FA"),
  );
  static Color activeIconColor = Color(
    getColorHexFromStr("#04D1D6"),
  );
  static Color inActiveIconColor = Color(
    getColorHexFromStr("#D9D9D9"),
  );
  static Color backGroundColor = Color(
    getColorHexFromStr("#FEFEFE"),
  );
  static Color cardColor = Color(
    getColorHexFromStr("#FFFFFF"),
  );
  static Color mainButtonColor = Color.fromARGB(0, 113, 202, 196);
  static Color acceptButtonColor = Color(getColorHexFromStr("#FFD32A"));
  static Color btnColor = Color(getColorHexFromStr("#01AAE5"));
  static Color subTitleColor = Color(getColorHexFromStr("#B5BED1"));
  static Color priceColor = Color(getColorHexFromStr("#F58A4F"));
  static Color counterColor = Color(getColorHexFromStr("#4DD894"));
  static Color rejectButtonColor = Color(getColorHexFromStr("#E11616"));
  static Color appBarColor = Color(getColorHexFromStr("#F6F7FA"));

  static const String fontName = 'JF-Flat';
  static const String boldFont = 'Cairo';
  static const String defaultImage =
      "https://cdn.pixabay.com/photo/2017/12/31/15/56/portrait-3052641_960_720.jpg";
  static const String defaultPersonImage =
      "https://cdn.pixabay.com/photo/2017/12/31/15/56/portrait-3052641_960_720.jpg";

  static const double sizedBoxHeight = 20;

  static const TextStyle mainButtonTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 15,
    letterSpacing: -0.31,
    height: 19,
    color: Colors.white,
  );
  static const BoxDecoration authMainDecoration = BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/icons/splash.png"),
      fit: BoxFit.fill,
    ),
  );
  static TextStyle inputTextStyle = TextStyle(
    fontFamily: fontName,
    fontSize: 10,
    letterSpacing: -0.17,
    height: 10,
    color: Colors.white,
  );

  static TextStyle inputHintStyle = TextStyle(
    fontFamily: fontName,
    fontSize: 8,
    letterSpacing: -0.17,
    height: 10,
    color: Color(getColorHexFromStr("#7C8184")),
  );

  static TextStyle titleStyle = TextStyle(
    fontFamily: boldFont,
    fontWeight: FontWeight.w800,
    fontSize: 14,
    color: primaryColor,
  );

  static TextStyle subTitleStyle = TextStyle(
    fontFamily: boldFont,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: secondaryColor,
  );
}
