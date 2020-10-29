import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master/Helpers/customWidget/NetworkDialog.dart';
import 'package:master/Screens/Client/Clien.dart';
import 'package:master/Screens/Mutual/loginType/view.dart';
import 'package:master/Screens/Provider/Provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String userType;

  void goToHomePage() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      userType = prefs.getString('userType');
      final result = await InternetAddress.lookup("googel.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("connected");
        Timer(Duration(seconds: 1), () {
          if (userType == "provider") {
            Get.off(
              Provider(),
            );
          } else if (userType == "client") {
            Get.off(
              Clin(),
            );
          } else {
            Get.off(
              LoginTypeView(),
            );
          }
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      showNetworkErrorDialog(context, () {
        Get.back();
        goToHomePage();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    SharedPreferences.getInstance().then((prefs) {});
    goToHomePage();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/icons/splash.png"), fit: BoxFit.fill),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Image.asset(
            "assets/icons/logo.png",
            width: 80,
          ),
        ),
      ),
    );
  }
}
