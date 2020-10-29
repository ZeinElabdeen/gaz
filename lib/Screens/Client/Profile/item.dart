import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Helpers/colors.dart';

profileItem({BuildContext context, String img, String key, String val}) {
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Container(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                right: 15,
                left: 15,
              ),
              child: Image(
                image: AssetImage(img),
                width: 25,
                height: 25,
              )),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  key,
                  style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      fontFamily: AppTheme.boldFont),
                ),
                Text(
                  val,
                  style: TextStyle(
                      color: Color(
                        getColorHexFromStr("#AFB8CE"),
                      ),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      fontFamily: AppTheme.boldFont),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
