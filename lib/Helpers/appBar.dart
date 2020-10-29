import 'package:flutter/material.dart';

import 'package:localize_and_translate/localize_and_translate.dart';
import 'app_theme.dart';

Widget appBar({BuildContext context, String title, bool leading}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: AppTheme.primaryColor,
    elevation: 0,
    automaticallyImplyLeading: false,
    leading: leading
        ? IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            })
        : Container(),
    title: Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 17),
    ),
  );
}

Widget appBarWithAction(
    {BuildContext context, String title, bool leading, Widget actionIcon}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: AppTheme.primaryColor,
    elevation: 0,
    automaticallyImplyLeading: false,
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: actionIcon,
      ),
    ],
    leading: leading
        ? IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            })
        : Container(),
    title: Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 17),
    ),
  );
}

Widget homeAppBar(Function onNotificationsTapped) {
  return AppBar(
    centerTitle: true,
    backgroundColor: AppTheme.primaryColor,
    elevation: 0,
    automaticallyImplyLeading: false,
    actions: <Widget>[
      IconButton(
        onPressed: onNotificationsTapped,
        icon: Icon(
          Icons.notifications,
          color: Colors.white,
          size: 25,
        ),
      ),
    ],
    title: Text(
      translator.currentLanguage == "en" ? "Home" : "الرئيسية",
      style: TextStyle(color: Colors.white, fontSize: 17),
    ),
    leading: IconButton(
      onPressed: () {
        //       Get.to(
        // ClientSearchScreen(),
        //       );
      },
      icon: Icon(
        Icons.search,
        color: Colors.white,
        size: 25,
      ),
    ),
  );
}
