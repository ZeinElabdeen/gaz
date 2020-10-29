import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../app_theme.dart';
import '../colors.dart';

Widget chooseTypeCard({BuildContext context, Function onTap, String txt}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        color: Color(
          getColorHexFromStr("#EFF0F5"),
        ),
      ),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 12),
            child: Text(
              txt,
              style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  fontFamily: AppTheme.boldFont),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Icon(
            Icons.add,
            color: AppTheme.primaryColor,
            size: 25,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    ),
  );
}
