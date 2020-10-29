import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:localize_and_translate/localize_and_translate.dart';
import '../Loaders.dart';
import '../app_theme.dart';
import '../colors.dart';
import 'Btns.dart';

Future<void> doneDialog({BuildContext context, String body, Function onTap}) {
  return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          actions: <Widget>[
            Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
              ),
              width: MediaQuery.of(context).size.width * .8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 20, bottom: 20),
                  //   child: Container(
                  //     width: 80,
                  //     height: 80,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(5),
                  //         image: DecorationImage(
                  //             image: AssetImage(""),
                  //             fit: BoxFit.cover)),
                  //   ),
                  // ),
                  Container(
                    width: MediaQuery.of(context).size.width * .7,
                    child: Text(
                      body,
                      style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(right: 30, left: 30, top: 20),
                      child: dialogBtn(
                          context,
                          translator.currentLanguage == "en"
                              ? "Back to home"
                              : "العودة للرئيسية",
                          onTap)),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        );
      });
}

Future<void> rateDialog(
    {BuildContext context,
    Function onButtonTap,
    Function onRatingUpdate,
    bool isLoading}) {
  return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          actions: <Widget>[
            Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
              ),
              width: MediaQuery.of(context).size.width * .8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  RatingBar(
                    initialRating: 3,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: AppTheme.primaryColor,
                    ),
                    unratedColor: Color(
                      getColorHexFromStr("#B8C0D3"),
                    ),
                    onRatingUpdate: onRatingUpdate,
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(right: 30, left: 30, top: 20),
                      child: isLoading
                          ? authLoader()
                          : dialogBtn(
                              context,
                              translator.currentLanguage == "en"
                                  ? "Send"
                                  : "ارسال",
                              onButtonTap)),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        );
      });
}

Future<void> deleteDialog({BuildContext context, Function onDeleteTapped}) {
  return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: new Text(
            translator.currentLanguage == 'ar'
                ? "تأكيد الحذف"
                : "Confirm deletion",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryColor,
                fontFamily: AppTheme.fontName),
          ),
          actions: <Widget>[
            new FlatButton(
              onPressed: onDeleteTapped,
              child: new Text(
                translator.currentLanguage == 'ar' ? "حذف" : "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: new Text(
                translator.currentLanguage == 'ar' ? "الغاء" : "Cancel",
                style: TextStyle(color: AppTheme.secondaryColor),
              ),
            ),
          ],
        );
      });
}
