import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../colors.dart';

Widget personalDataCard(
    {BuildContext context,
      Function onTap,
      String img,
      String userName,
      String mobile,
      bool isUpdate,
      Function onEditSubmitted}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: InkWell(
      onTap: onTap,
      child: Material(
        elevation: 1,
        child: Container(
          color: Color(getColorHexFromStr("#FFFFFF")),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(img),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(width: 2, color: AppTheme.primaryColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    userName,
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        fontFamily: AppTheme.fontName),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    mobile,
                    style: TextStyle(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        fontFamily: AppTheme.fontName),
                  ),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              isUpdate
                  ? InkWell(
                onTap: onEditSubmitted,
                child: Image.asset(
              "assets/icons/edit.png",width: 20,height: 30,
                ),
              )
                  : Container(),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
