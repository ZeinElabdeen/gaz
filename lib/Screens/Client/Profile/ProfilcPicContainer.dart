import 'package:flutter/material.dart';
import 'package:master/Helpers/app_theme.dart';

Widget profilePicContainer(
    {BuildContext context,
    String img,
    String name,
    Function onProfilePicTapped}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 250,
    decoration: BoxDecoration(
        color: AppTheme.backGroundColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))),
    child: Padding(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: onProfilePicTapped,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(img), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(90),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            name,
            style: TextStyle(
                color: AppTheme.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                fontFamily: AppTheme.boldFont),
          )
        ],
      ),
    ),
  );
}
