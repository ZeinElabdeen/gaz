import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../app_theme.dart';

Widget noSearchDataFound(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * .8,
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
              ? "No search data found"
              : "لا توجد نتائج بحث",
          style: TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              fontFamily: AppTheme.boldFont),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget noDataFound(BuildContext context, String txt) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * .65,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.asset(
          "assets/icons/logo.png",
          width: MediaQuery.of(context).size.width * .6,
          height: MediaQuery.of(context).size.width * .6,
        ),
        Text(
          txt,
          style: TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              fontFamily: AppTheme.boldFont),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
