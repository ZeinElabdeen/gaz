import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/app_theme.dart';

Widget paymentSummaryCard(
    {String productsPrice,
    String additionalTax,
    String shippingPrice,
    String total}) {
  return Padding(
    padding: const EdgeInsets.only(right: 10, left: 10, bottom: 20, top: 10),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: .01),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              translator.currentLanguage == "en"
                  ? "Order summary"
                  : "ملخص الطلب",
              style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 15,
                  fontFamily: AppTheme.boldFont,
                  fontWeight: FontWeight.w900),
            ),
          ),
          _item(
              translator.currentLanguage == "en"
                  ? "Products price"
                  : "سعر المتجات",
              productsPrice),
          _item(
              translator.currentLanguage == "en"
                  ? "Additional tax"
                  : "ضريبة القيمة المضافة",
              additionalTax),
          _item(
              translator.currentLanguage == "en"
                  ? "Shipping value"
                  : "قيمة التوصيل",
              shippingPrice),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 5,
              ),
              Text(
                translator.currentLanguage == "en"
                    ? "Total price"
                    : "المبلغ الاجمالى",
                style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w900),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                "$total ${translator.currentLanguage == "en" ? "Sar" : "ريال"}",
                style: TextStyle(
                    color: AppTheme.accentColor,
                    fontSize: 16,
                    fontFamily: AppTheme.boldFont,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
        ],
      ),
    ),
  );
}

Widget _item(key, val) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 5,
        ),
        Text(
          key,
          style: TextStyle(
              color: AppTheme.secondaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w900),
        ),
        Expanded(
          child: Container(),
        ),
        Text(
          "$val ${translator.currentLanguage == "en" ? "Sar" : "ريال"}",
          style: TextStyle(
              color: AppTheme.accentColor,
              fontSize: 15,
              fontWeight: FontWeight.w800),
        ),
        SizedBox(
          width: 5,
        ),
      ],
    ),
  );
}
