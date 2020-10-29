import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/AwsomeDialog.dart';
import 'package:master/Helpers/CustomWidgets/PersonalInfoCard.dart';
import 'package:master/Helpers/appBar.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Helpers/prefs.dart';
import 'package:master/Screens/Client/Addresses/view.dart';
import 'package:master/Screens/Client/Profile/view.dart';
import 'package:master/Screens/Client/UpdateProfile/view.dart';
import 'package:master/Screens/Mutual/About/view.dart';
import 'package:master/Screens/Mutual/ContatctUs/view.dart';
import 'package:master/Screens/Mutual/Policy/view.dart';
import 'package:master/Screens/Mutual/splashViw/SplashView.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientMoreView extends StatefulWidget {
  @override
  _ClientMoreViewState createState() => _ClientMoreViewState();
}

class _ClientMoreViewState extends State<ClientMoreView> {
  Widget _item(String txt, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    txt,
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        fontFamily: AppTheme.boldFont),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppTheme.primaryColor,
                    size: 20,
                  ),
                ],
              )),
          Container(
            height: .3,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  String name, mobile, profile, token;

  _getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      mobile = prefs.getString('mobile');

      profile = prefs.getString('profile');
      token = prefs.getString('token');

      print("   >>>>>>>>>>>>>>>>>>>>>>>     " +
          token +
          "       <<<<<<<<<<<<<<<<<<<<<<<");
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: translator.currentLanguage == "en"
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppTheme.backGroundColor,
          appBar: appBar(
              context: context,
              title:
                  translator.currentLanguage == "en" ? "My account" : "حسابى",
              leading: false),
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  name == null
                      ? Container()
                      : personalDataCard(
                          context: context,
                          isUpdate: true,
                          img: profile,
                          onTap: () {
                            Get.to(
                              ClientProfileView(),
                            ).then((value) {
                              _getData();
                            });
                          },
                          userName: name,
                          mobile: mobile,
                          onEditSubmitted: () {
                            Get.to(
                              ClientUpdateProfileView(),
                            ).then((value) {
                              _getData();
                            });
                          }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 1,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            _item(
                                translator.currentLanguage == "en"
                                    ? "Addresses"
                                    : "العناوين", () {
                              token == null
                                  ? visitorDialog(context)
                                  : Get.to(
                                      ClientAddressesView(),
                                    );
                            }),
                            _item(
                                translator.currentLanguage == "en"
                                    ? "Share app"
                                    : "مشاركة التطبيق", () {
                              Share.share(
                                  "https://play.google.com/store/apps/details?id=com.rmalsa.gas"); //TODO landing page link
                            }),
                            _item(
                                translator.currentLanguage == "en"
                                    ? "Policy"
                                    : "شروط الاستخدام", () {
                              Get.to(
                                PolicyView(),
                              );
                            }),
                            _item(
                                translator.currentLanguage == "en"
                                    ? "About app"
                                    : "نبذة عن التطبيق", () {
                              Get.to(
                                AboutAppView(),
                              );
                            }),
                            _item(
                                translator.currentLanguage == "en"
                                    ? "Contact us"
                                    : "اتصل بنا", () {
                              Get.to(
                                ContactUsView(),
                              );
                            }),
//                            _item(
//                                translator.currentLanguage == "en"
//                                    ? "العربية"
//                                    : "English", () {
//                              translator.currentLanguage == "en"
//                                  ? translator.setNewLanguage(
//                                      context,
//                                      newLanguage: 'ar',
//                                      remember: true,
//                                      restart: true,
//                                    )
//                                  : translator.setNewLanguage(
//                                      context,
//                                      newLanguage: 'en',
//                                      remember: true,
//                                      restart: true,
//                                    );
//                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _logOutItem(
                      translator.currentLanguage == "en"
                          ? "Log out"
                          : "تسجيل الخروج", () {
                    Prefs.clear().then((value) {
                      Get.offAll(
                        SplashView(),
                      );
                    });
                  }),
                ],
              )),
        ),
      ),
    );
  }

  Widget _logOutItem(String txt, Function onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 8,
                ),
                Text(
                  txt,
                  style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      fontFamily: AppTheme.boldFont),
                ),
                Expanded(
                  child: Container(),
                ),
                Image.asset(
                  "assets/icons/logout.png",
                  width: 20,
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
