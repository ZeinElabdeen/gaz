import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../app_theme.dart';


Widget createNewAccount(BuildContext context,Function onTap){
  return     Padding(
    padding: const EdgeInsets.only(bottom: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          translator.currentLanguage == "en"
              ? "Doesn't have account"
              : 'ليس لديك حساب ؟؟',
          style: TextStyle(
              color: AppTheme.secondaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap:onTap,
          child: Text(
            translator.currentLanguage == "en" ? "Create account" : 'سجل الان',
            style: TextStyle(
                color: AppTheme.primaryColor,
                fontSize: 15,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}


Widget forgetPasswordText(BuildContext context,Function onTap){
  return     Padding(
    padding: const EdgeInsets.only(bottom: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        InkWell(
          onTap: onTap,
          child: Text(
            translator.currentLanguage == "en"
                ? "Forget password"
                : 'نسيت كلمة المرور',
            style: TextStyle(
                color: AppTheme.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
SizedBox(width: 12,),
      ],
    ),
  );
}


Widget alreadyHaveAccount(BuildContext context,Function onTap){
  return     Padding(
    padding: const EdgeInsets.only(bottom: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          translator.currentLanguage == "en"
              ? "Already have account"
              : 'لديك بالقعل حساب',
          style: TextStyle(
              color: AppTheme.secondaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap:onTap,
          child: Text(
            translator.currentLanguage == "en" ? "Sign in" : 'تسجيل الدخول',
            style: TextStyle(
                color: AppTheme.primaryColor,
                fontSize: 15,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

