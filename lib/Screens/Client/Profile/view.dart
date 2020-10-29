import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/Loaders.dart';
import 'package:master/Helpers/appBar.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Screens/Client/UpdateProfile/view.dart';
import 'package:master/Screens/Mutual/Auth/UpdatePassword/view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ProfilcPicContainer.dart';
import 'item.dart';

class ClientProfileView extends StatefulWidget {
  @override
  _ClientProfileViewState createState() => _ClientProfileViewState();
}

class _ClientProfileViewState extends State<ClientProfileView> {
  String name, mobile, city, profile, token, email;
  int cityId, id;
  bool _loading = true;
  _getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      mobile = prefs.getString('mobile');
      city = prefs.getString('city');
      email = prefs.getString('email');
      profile = prefs.getString('profile');
      token = prefs.getString('token');
      cityId = prefs.getInt('cityId');
      id = prefs.getInt('id');
      print(token + "           0000000000000000000000000000");
      print(id.toString() + "           0000000000000000000000000000");
      _loading = false;
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
      backgroundColor: AppTheme.backGroundColor,
      appBar: appBar(
          context: context,
          title: translator.currentLanguage == "en"
              ? "Profile"
              : "البيانات الشخصية",
          leading: true),
      body: _loading == null
          ? loader()
          : ListView(
              children: <Widget>[
                profilePicContainer(
                    context: context,
                    name: name,
                    onProfilePicTapped: () {},
                    img: profile),
                Row(
                  children: <Widget>[
                    profileItem(
                        context: context,
                        img: "assets/icons/user.png",
                        key: translator.currentLanguage == "en"
                            ? "Name"
                            : "الاسم",
                        val: name),
                    Expanded(
                      child: Container(),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(
                          ClientUpdateProfileView(),
                        ).then((value) {
                          _getData();
                        });
                      },
                      child: Image(
                        image: AssetImage("assets/icons/edit.png"),
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),

                //  remove mobile from edit
                //  replace country with city
                profileItem(
                    context: context,
                    img: "assets/icons/phone.png",
                    key: translator.currentLanguage == "en"
                        ? "Mobile number"
                        : "رقم الجوال",
                    val: mobile),
                profileItem(
                    context: context,
                    img: "assets/icons/mail.png",
                    key: translator.currentLanguage == "en"
                        ? "Email"
                        : "البريد الالكترونى",
                    val: email),
                profileItem(
                    context: context,
                    img: "assets/icons/location_orange.png",
                    key:
                        translator.currentLanguage == "en" ? "City" : "المدينة",
                    val: city),
                Row(
                  children: <Widget>[
                    profileItem(
                        context: context,
                        img: "assets/icons/password.png",
                        key: translator.currentLanguage == "en"
                            ? "Password"
                            : "كلمة المرور",
                        val: "*********"),
                    Expanded(
                      child: Container(),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(
                          UpdatePasswordView(
                            type: "client",
                          ),
                        );
                      },
                      child: Image(
                        image: AssetImage("assets/icons/edit.png"),
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ],
            ),
    );
  }
}
