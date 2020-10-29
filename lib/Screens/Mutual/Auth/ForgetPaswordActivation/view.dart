import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/AuthWidgets/logo.dart';
import 'package:master/Helpers/CustomWidgets/Btns.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Screens/Mutual/Auth/ResetPassword/view.dart';
import 'package:toast/toast.dart';

import '../PinLength.dart';

class ForgetPasswordActivationView extends StatefulWidget {
  final String type;
  final String mobile;
  final String code;

  const ForgetPasswordActivationView(
      {Key key, this.type, this.mobile, this.code})
      : super(key: key);

  @override
  _ForgetPasswordActivationViewState createState() =>
      _ForgetPasswordActivationViewState();
}

class _ForgetPasswordActivationViewState
    extends State<ForgetPasswordActivationView> {
  TextEditingController code = TextEditingController();
  void _submit() {
    if (code.text != widget.code) {
      Toast.show(
          translator.currentLanguage == "en"
              ? "Please check verification code"
              : "من فضلك تأكد من كود التفعيل",
          context,
          gravity: Toast.CENTER);
    } else {
      Get.to(ResetPasswordView(
        type: widget.type,
        mobile: widget.mobile,
        code: widget.code,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: AppTheme.authMainDecoration,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              authLogo(
                  context: context,
                  welcomeMessage: translator.currentLanguage == "en"
                      ? "Reset password"
                      : "استرجاع كلمة المرور",
                  title: translator.currentLanguage == "en"
                      ? "Please enter code that sent to your mobile"
                      : "قم بادخال الكود المكون من 4 أرقام المرسل على رقم هاتفك"),
              pinLength(context: context, onChange: (val) {}, controller: code),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  translator.currentLanguage == "en"
                      ? "Edit mobile number"
                      : "تعديل رقم الجوال",
                  style: TextStyle(
                      color: AppTheme.rejectButtonColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 60,
              ),
//              Padding(
//                padding: const EdgeInsets.only(top: 8, bottom: 20),
//                child: Text(
//                  "1:30",
//                  style: TextStyle(
//                      color: AppTheme.primaryColor,
//                      fontSize: 14,
//                      fontWeight: FontWeight.w400),
//                ),
//              ),

              btn(context,
                  translator.currentLanguage == "en" ? "Send" : "ارسال", () {
                _submit();
              }),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String password;
  bool obscureText = true;
}
