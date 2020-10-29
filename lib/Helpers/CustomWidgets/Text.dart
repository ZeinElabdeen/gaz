import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../app_theme.dart';


Widget titleText(String txt){
  return   Padding(
    padding: const EdgeInsets.only(right: 10,left: 10),
    child: Text(
     txt,
      style: TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 16,
          fontFamily: AppTheme.boldFont,
          fontWeight: FontWeight.w900),
    ),
  );
}
Widget priceText(String txt){
  return   Padding(
    padding: const EdgeInsets.only(right: 10,left: 10),
    child: Text(
     "$txt ${translator.currentLanguage =="en"?"Sar":"رس"}",
      style: TextStyle(
          color: AppTheme.priceColor,
          fontSize: 16,
          fontFamily: AppTheme.boldFont,
          fontWeight: FontWeight.w900),
    ),
  );
}
Widget bottomSheetTitle(String txt){
  return    Row

    (
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 30,
          width: 30,
        ),
      ),
      Text(
       txt,
        style: TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 15,
          fontWeight: FontWeight.w900,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          height: 30,
          width: 30,
          child: Center(
            child: IconButton(
              onPressed: () {
               Get.back();
              },
              icon: Icon(
                Icons.close,
                color: AppTheme.secondaryColor,
                size: 15,
              ),
            ),
          ),
        ),
      )
    ],
  );
}