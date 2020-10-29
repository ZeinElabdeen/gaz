import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Helpers/colors.dart';

Widget cartItemCard({
  BuildContext context,
  String img,
  String price,
  Function onDeleteTapped,
  Widget counter,
  String productName,
  Function onEditTapped,
  bool editLoading,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(getColorHexFromStr("#FFFFFF")),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              image: NetworkImage(img),
              width: 80,
              height: 80,
              fit: BoxFit.fill,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    productName,
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Text(
                      "$price ${translator.currentLanguage == "en" ? "Sar" : "رس"}",
                      style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 12),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      counter,
                      SizedBox(
                        width: 20,
                      ),
                      editLoading
                          ? CupertinoActivityIndicator(
                              animating: true,
                              radius: 10,
                            )
                          : InkWell(
                              onTap: onEditTapped,
                              child: Image.asset(
                                "assets/icons/edit.png",
                                width: 20,
                                height: 20,
                              )),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
                onTap: onDeleteTapped,
                child: Image(
                  image: AssetImage("assets/icons/delete.png"),
                  width: 15,
                  height: 25,
                ))
          ],
        ),
      ),
    ),
  );
}

Widget totalText({String total}) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 6,
      ),
      Text(
        translator.currentLanguage == "en" ? "Total" : "الاجمالى",
        style: TextStyle(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            fontFamily: AppTheme.boldFont),
      ),
      Expanded(
        child: Container(),
      ),
      Text(
        "$total ${translator.currentLanguage == "en" ? "Sar" : "رس"}",
        style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            fontFamily: AppTheme.boldFont),
      ),
      SizedBox(
        width: 6,
      ),
    ],
  );
}
