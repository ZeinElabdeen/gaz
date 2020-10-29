import 'package:flutter/material.dart';
import '../../app_theme.dart';


Widget authLogo({BuildContext context,String welcomeMessage,String title}){
  return          Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 20),
          child: Center(
              child: Image.asset(
                "assets/icons/logo.png",
                width: MediaQuery.of(context).size.width * .5,
                height: 200,
              )),
        ),
        Text(
         welcomeMessage,
          style: TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 14,fontFamily: AppTheme.boldFont,
              fontWeight: FontWeight.w900),
        ),SizedBox(height: 10,),
        Text(
          title,
          style: TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w600),
        ),SizedBox(height: 30,),
      ],
    ),
  );
}