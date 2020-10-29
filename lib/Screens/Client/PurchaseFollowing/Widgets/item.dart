import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:master/Helpers/app_theme.dart';

Widget productDetailsItem(
    {BuildContext context,
    String img,
    String title,
    String description,
    Function onTap}) {
  return Padding(
    padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
    child: InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: .3),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(img),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Text(
                            title,
                            style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Text(
                          description,
                          style: TextStyle(
                              color: AppTheme.secondaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: AppTheme.primaryColor,
                  ),
                ],
              ),
            ),

//        SizedBox(
//          height: 5,
//        ),
//        Row(
//          crossAxisAlignment:
//          CrossAxisAlignment.start,
//          mainAxisAlignment:
//          MainAxisAlignment.start,
//          children: <Widget>[
//            Text(
//              "${translator.currentLanguage == "en" ? "Quantity : " : "الكمية : "} $qty",
//              style: TextStyle(
//                  color: AppTheme.secondaryColor,
//                  fontSize: 13,
//                  fontWeight: FontWeight.w700),
//            ),
//            SizedBox(
//              width: 20,
//            ),
//            Text(
//              "$price ${translator.currentLanguage == "en" ? "Sar" : "ريال"}",
//              style: TextStyle(
//                  color: AppTheme.primaryColor,
//                  fontSize: 13,
//                  fontWeight: FontWeight.w700),
//            ),
//          ],
//        )
          ],
        ),
      ),
    ),
  );
}
