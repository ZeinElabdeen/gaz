import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

void showNetworkErrorDialog(BuildContext context, Function onTap) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        content: Text(
          translator.currentLanguage == "en"
              ? "please check your internet connection"
              : "تأكد من الاتصال بالانترنت",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.blue,
          ),
        ),
        actions: <Widget>[
          CupertinoButton(
            onPressed: onTap,
            child: Text(
              translator.currentLanguage == "en"
                  ? "Try again"
                  : "حاول مرة أخرى",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      );
    },
  );
}
