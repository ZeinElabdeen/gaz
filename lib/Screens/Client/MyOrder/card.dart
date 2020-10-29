import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Helpers/colors.dart';

Widget providerOrderCard(
    {BuildContext context,
    Function onTap,
    String orderNo,
    String time,
    String createdAt,
    String productsNo,
    bool isCurrent,
    String price}) {
  return Padding(
    padding: const EdgeInsets.only(top: 4, bottom: 4),
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: 90,
        color: AppTheme.cardColor,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${translator.currentLanguage == "ar" ? "طلب " : "Order "} $orderNo",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        fontFamily: AppTheme.boldFont),
                  ),
                  Text(
                    "$productsNo ${translator.currentLanguage == "ar" ? "منتجات" : "Products"} ",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: Color(
                          getColorHexFromStr("#9CA8C1"),
                        ),
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                        fontFamily: AppTheme.boldFont),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        translator.currentLanguage == "en"
                            ? "Delivery :"
                            : " التسليم : ",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: Color(
                              getColorHexFromStr("#9CA8C1"),
                            ),
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                            fontFamily: AppTheme.boldFont),
                      ),
                      Text(
                        time,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: Color(
                              getColorHexFromStr("#9CA8C1"),
                            ),
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                            fontFamily: AppTheme.boldFont),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          createdAt,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Color(
                                getColorHexFromStr("#9CA8C1"),
                              ),
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              fontFamily: AppTheme.boldFont),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "$price  ${translator.currentLanguage == "en" ? "Sar" : "رس"}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: isCurrent
                                  ? AppTheme.primaryColor
                                  : AppTheme.accentColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              fontFamily: AppTheme.boldFont),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
