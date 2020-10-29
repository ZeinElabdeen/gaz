import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Helpers/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

Widget pinLength(
    {BuildContext context,
    Function onChange,
    TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
    child: Directionality(
      textDirection: translator.currentLanguage == 'en'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: PinCodeTextField(
        onChanged: onChange,
        length: 4, controller: controller,
        obsecureText: false, textInputType: TextInputType.number,
        animationType: AnimationType.fade,
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.white.withOpacity(0),
        textInputAction: TextInputAction.done,
        enableActiveFill: true,
        enabled: true, animationCurve: Curves.ease,
        autoFocus: true,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        autoDisposeControllers: true, autoDismissKeyboard: true,
        pinTheme: PinTheme(
          selectedColor: AppTheme.primaryColor,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(60),
          fieldHeight: 40,
          fieldWidth: 70,
          activeFillColor: Colors.white,
          inactiveColor: Colors.transparent,
          activeColor: AppTheme.primaryColor,
          disabledColor: AppTheme.primaryColor,
          borderWidth: .5,
          selectedFillColor: AppTheme.thirdColor,
          inactiveFillColor: Color(
            getColorHexFromStr("#F1F2F7"),
          ),
        ),

        //  shape: PinCodeFieldShape.box,
        //  borderRadius: BorderRadius.circular(5),
        //  fieldWidth: 60,
//                  activeFillColor: Color(
//                    getColorHexFromStr("#F5F5F5"),
//                  ),
      ),
    ),
  );
}
