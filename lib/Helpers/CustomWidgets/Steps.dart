import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:localize_and_translate/localize_and_translate.dart';

import '../app_theme.dart';
import '../colors.dart';

double containerImageSize = 25;
double itemSize = .30;
TextStyle activeTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 13,
  fontWeight: FontWeight.w700,
);
TextStyle inActiveTextStyle = TextStyle(
  color: AppTheme.secondaryColor,
  fontSize: 13,
  fontWeight: FontWeight.w700,
);
Color activeBackGroundColor = AppTheme.primaryColor;
Color inActiveBackGroundColor = AppTheme.secondaryColor;
Color activeContainerColor = AppTheme.primaryColor;
Color inActiveContainerColor = Color(
  getColorHexFromStr("#F1F1F1"),
);

Widget stepsWidget({BuildContext context, int status}) {
  return Container(
    height: 35,
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    child: Container(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: AppTheme.primaryColor,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width * itemSize,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: containerImageSize,
                      height: containerImageSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: status == 1 || status == 2 || status == 3
                            ? Color(getColorHexFromStr("#4C76AC"))
                            : Color(
                                getColorHexFromStr("#BFBFBF"),
                              ),
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/icons/received.png",
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .2 - 40,
                      child: AutoSizeText(
                        translator.currentLanguage == "en"
                            ? "Accepted" // Changed logically
                            : 'تم القبول',
                        maxFontSize: 14,
                        minFontSize: 8,
                        maxLines: 1,
                        style: status == 1 || status == 2 || status == 3
                            ? activeTextStyle
                            : inActiveTextStyle,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: status == 1 || status == 2 || status == 3
                      ? activeContainerColor
                      : inActiveContainerColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * itemSize,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: containerImageSize,
                      height: containerImageSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: status == 2 || status == 3
                            ? Color(getColorHexFromStr("#4C76AC"))
                            : Color(
                                getColorHexFromStr("#BFBFBF"),
                              ),
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/icons/way.png",
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * itemSize - 40,
                      child: AutoSizeText(
                        translator.currentLanguage == "en"
                            ? "In way"
                            : 'في الطريق',
                        maxFontSize: 14,
                        minFontSize: 8,
                        maxLines: 1,
                        style: status == 2 || status == 3
                            ? activeTextStyle
                            : inActiveTextStyle,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: status == 2 || status == 3
                      ? activeContainerColor
                      : inActiveContainerColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * itemSize,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: containerImageSize,
                      height: containerImageSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: status == 3
                            ? Color(getColorHexFromStr("#4C76AC"))
                            : Color(
                                getColorHexFromStr("#BFBFBF"),
                              ),
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/icons/finishorder.png",
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * itemSize - 40,
                      child: AutoSizeText(
                        translator.currentLanguage == "en"
                            ? "Delivered"
                            : 'تم التسليم',
                        maxFontSize: 14,
                        minFontSize: 8,
                        maxLines: 1,
                        style:
                            status == 3 ? activeTextStyle : inActiveTextStyle,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: status == 3
                      ? AppTheme.primaryColor
                      : Color(
                          getColorHexFromStr("#F1F1F1"),
                        ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
