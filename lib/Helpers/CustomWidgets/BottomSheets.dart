import 'package:flutter/material.dart';

import 'package:localize_and_translate/localize_and_translate.dart';
import '../app_theme.dart';
import 'Btns.dart';

Future bottomSheet(
    {BuildContext context, String body, String btnText, Function onTap}) {
  return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      builder: (BuildContext context) {
        return Directionality(
          textDirection: translator.currentLanguage == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: AppTheme.backGroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      body,
                      style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  btn(context, btnText, onTap),
                ],
              )),
        );
      });
}
