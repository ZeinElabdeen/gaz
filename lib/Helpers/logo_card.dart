//import 'package:flutter/material.dart';
//import 'package:localize_and_translate/localize_and_translate.dart';
//import 'package:mazad_phone/Helpers/app_theme.dart';
//
//Widget logoCard() {
//  return Container(
//    width: 120,
//    margin: EdgeInsets.only(top: 50, bottom: 50),
//    height: 120,
//    decoration: BoxDecoration(
//        image: DecorationImage(image: AssetImage('assets/splashLogo.png'))),
//  );
//}
//
//
//Widget authLogo({BuildContext context,String txt}){
//  return Column(
//    children: <Widget>[
//      logoCard(),
//      Text(
//        txt,
//        style: TextStyle(color: AppTheme.primaryColor, fontSize: 17,fontWeight: FontWeight.w900),
//      ),
//      SizedBox(height: 30,)
//    ],
//  );
//}
//Widget alreadyHaveAccount({BuildContext context,Function onLoginTapped}){
//  return     Padding(
//    padding: const EdgeInsets.only(bottom: 25),
//    child: Row(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        Text(
//          translator.currentLanguage == "en"
//              ? "Already have account"
//              : 'لديك حساب بالفعل ؟',
//          style: TextStyle(
//              color: AppTheme.secondaryColor,
//              fontSize: 14,
//              fontWeight: FontWeight.bold),
//        ),
//        SizedBox(
//          width: 10,
//        ),
//        InkWell(
//          onTap:onLoginTapped,
//          child: Text(
//            translator.currentLanguage == "en" ? "Login" : 'تسجيل دخول',
//            style: TextStyle(
//                color: AppTheme.secondaryColor,
//                fontSize: 15,
//                decoration: TextDecoration.underline,
//                fontWeight: FontWeight.bold),
//          ),
//        ),
//      ],
//    ),
//  );
//}
//
//Widget createNewAccount(BuildContext context){
//  return     Padding(
//    padding: const EdgeInsets.only(bottom: 25),
//    child: Row(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        Text(
//          translator.currentLanguage == "en"
//              ? "Doesn't have account"
//              : 'ليس لديك حساب ؟؟',
//          style: TextStyle(
//              color: AppTheme.secondaryColor,
//              fontSize: 14,
//              fontWeight: FontWeight.bold),
//        ),
//        SizedBox(
////          width: 10,
//        ),
//        InkWell(
//          onTap:(){Navigator.of(context).pop();},
//          child: Text(
//            translator.currentLanguage == "en" ? "Create account" : 'انشاء حساب',
//            style: TextStyle(
//                color: AppTheme.secondaryColor,
//                fontSize: 15,
//                decoration: TextDecoration.underline,
//                fontWeight: FontWeight.bold),
//          ),
//        ),
//      ],
//    ),
//  );
//}
//
