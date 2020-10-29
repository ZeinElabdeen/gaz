import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/Btns.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Screens/Client/Auth/Singin/SingIn.dart';

class LoginTypeView extends StatefulWidget {
  @override
  _LoginTypeViewState createState() => _LoginTypeViewState();
}

class _LoginTypeViewState extends State<LoginTypeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Directionality(
            textDirection: translator.currentLanguage == "en"
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/icons/splash.png"),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 50),
                    child: Image(
                      image: AssetImage("assets/icons/logo.png"),
                      height: 200,
                    ),
                  ),
                  Center(
                    child: Text(
                      translator.currentLanguage == "en"
                          ? "Login as"
                          : "تسجيل الدخول كـــ",
                      style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 20,
                          fontFamily: AppTheme.boldFont,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  btn(
                    context,
                    translator.currentLanguage == "en" ? "Client" : "عميل",
                    () {
                      Get.to(
                        ClientSingIn(),
                        //       ClientBottomNavigationView(),
                      );
                    },
                  ),
                  btn(context,
                      translator.currentLanguage == "en" ? "Provider" : "مندوب",
                      () {
                    // Get.to(
                    //   //      ProviderBottomNavigationView(),
                    //   ProviderSignInView(),
                    // );
                  }),
                  InkWell(
                    onTap: () {
                      // Get.to(
                      //   ClientBottomNavigationView(),
                      // );
                    },
                    child: Center(
                      child: Text(
                        translator.currentLanguage == "en"
                            ? "Login as visitor"
                            : "الدخول كزائر",
                        style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 13,
                            fontFamily: AppTheme.boldFont,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
