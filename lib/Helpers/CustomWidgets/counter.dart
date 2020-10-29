import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../app_theme.dart';
import '../colors.dart';

typedef void CounterChangeCallback(num value);
  Color counterColor = Color(getColorHexFromStr("#4DD894"));
  Color counterBorderColor = Color(getColorHexFromStr("#B5B4B4"));
  double borderWidth =.2;

class Counterwidget extends StatelessWidget {
  final CounterChangeCallback onChanged;

  Counterwidget({
    Key key,
    @required num initialValue,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    @required this.decimalPlaces,
    @required this.width,
    this.color,
    this.textStyle,
    this.step = 1,
    this.buttonSize = 25,
  })  : assert(initialValue != null),
        assert(minValue != null),
        assert(maxValue != null),
        assert(maxValue > minValue),
        assert(initialValue >= minValue && initialValue <= maxValue),
        assert(step > 0),
        selectedValue = initialValue,
        super(key: key);

  ///min value user can pick
  final num minValue;

  ///max value user can pick
  final num maxValue;

  /// decimal places required by the counter
  final int decimalPlaces;

  ///Currently selected integer value
  num selectedValue;
  ///Currently selected integer value
final double width;
  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final num step;

  /// indicates the color of fab used for increment and decrement
  Color color;

  /// text syle
  TextStyle textStyle;

  final double buttonSize;

  void _incrementCounter() {
    if (selectedValue + step <= maxValue) {
      onChanged((selectedValue + step));
    }
  }

  void _decrementCounter() {
    if (selectedValue - step >= minValue) {
      onChanged((selectedValue - step));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    color = color ?? themeData.accentColor;
    textStyle = textStyle ??
        new TextStyle(
          fontSize: 20.0,
        );

    return Directionality(
      textDirection: translator.currentLanguage == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Container(
        width: width,
        //decoration: BoxDecoration(color: Colors.red),
        height: 35,
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: _decrementCounter,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: borderWidth,
                      color: counterBorderColor,
                    ),
                    borderRadius: translator.currentLanguage == 'en'
                        ? BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    )
                        : BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Color(getColorHexFromStr("#F9F9FB"))),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Icon(

                      Icons.minimize,
                      color: AppTheme.primaryColor,
                    ),
                  ),
//                  Image.asset(
//                    "assets/icons/subtract.png",
//                    width: 80,
//                    height: 80,
//                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Color(getColorHexFromStr("#F9F9FB")),
                  border: Border.all(
                    color: counterBorderColor,                      width: borderWidth,

                  ),
                ),
                child: Center(
                  child: Text(
                    ' ${num.parse((selectedValue).toStringAsFixed(decimalPlaces))}',
                    style: TextStyle(
                      color: Color(getColorHexFromStr("#737C8B")),
                      fontFamily: AppTheme.fontName,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: _incrementCounter,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(getColorHexFromStr("#F9F9FB")),
                  border: Border.all(
                    color: counterBorderColor,                      width: borderWidth,

                  ),
                  borderRadius: translator.currentLanguage == 'en'
                      ? BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )
                      : BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: AppTheme.primaryColor,
                  ),
//                  Image.asset(
//                    "assets/icons/add.png",
//                    width: 80,
//                    height: 80,
//                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // return new Container(
    //   padding: new EdgeInsets.all(4.0),
    //   child: new Row(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Center(
    //        child: IconButton(
    //          onPressed: _decrementCounter,
    //          icon: Icon(Icons.remove),
    //        ),
    //         ),
    //       new Container(
    //         padding: EdgeInsets.all(4.0),
    //         child: new Text(
    //             '${num.parse((selectedValue).toStringAsFixed(decimalPlaces))}',
    //             style: textStyle),
    //       ),
    //       Center(
    //         child: IconButton(
    //           onPressed: _incrementCounter,
    //           icon: Icon(Icons.add),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
