import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Helpers/colors.dart';

Widget clientOrdersTabs(context, TabController _controller) {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Colors.white,
            child: TabBar(
              labelPadding: EdgeInsets.only(right: 3, left: 3),
              // isScrollable: false,
              controller: _controller,
              unselectedLabelColor: Color(getColorHexFromStr("#acacac")),
              labelColor: AppTheme.primaryColor,
              indicatorColor: AppTheme.primaryColor,
//            onTap: (index) {
//              if (index == 0) {
//              } else {}
//            },
              tabs: [
                Container(
                  //  width: MediaQuery.of(context).size.width / 3 - 8,
                  height: 40,
                  child: Tab(
                    child: Text(
                      translator.currentLanguage == "en"
                          ? "Current"
                          : "الحالية",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  //  width: MediaQuery.of(context).size.width / 3 - 8,
                  height: 40,
                  child: Tab(
                    child: Text(
                      translator.currentLanguage == "en"
                          ? "Expired"
                          : "المنتهية",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ],
  );
}
