import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/app_theme.dart';

Widget productDetailsCard(
    {BuildContext context, String img, String qty, String price, String name}) {
  return Padding(
    padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
    child: Material(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      elevation: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 60,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                image:
                    DecorationImage(image: NetworkImage(img), fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              width: 6,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w800),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      "${translator.currentLanguage == "en" ? "Quantity : " : "الكمية : "} $qty",
                      style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Text(
                    "$price ${translator.currentLanguage == "en" ? "Sar" : "ريال"}",
                    style: TextStyle(
                        color: AppTheme.accentColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
