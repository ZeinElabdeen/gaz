import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/AuthWidgets/AlreadyHaveAccount.dart';
import 'package:master/Helpers/CustomWidgets/AuthWidgets/logo.dart';
import 'package:master/Helpers/CustomWidgets/Btns.dart';
import 'package:master/Helpers/CustomWidgets/NetworkDialog.dart';
import 'package:master/Helpers/CustomWidgets/TextFormFields.dart';
import 'package:master/Helpers/Loaders.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Screens/Client/Auth/Singin/controller.dart';
import 'package:master/Screens/Client/Auth/SngUp/SingUp.dart';
import 'package:master/Screens/Client/Clien.dart';
import 'package:master/Screens/Mutual/Auth/ForgetPassword/view.dart';
import 'package:toast/toast.dart';

class ClientSingIn extends StatefulWidget {
  @override
  _ClientSingInState createState() => _ClientSingInState();
}

class _ClientSingInState extends State<ClientSingIn> {
  bool _loading = false;
  String mobile, password;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ClientSignInController _clientSignInController = ClientSignInController();
  void _submit(BuildContext context) {
    if (!_formKey.currentState.validate())
      return;
    else {
      _formKey.currentState.save();
      setState(() {
        _loading = true;
      });
      _clientSignInController
          .userSignIn(
        phone: mobile,
        password: password,
      )
          .then((response) {
        print(response.response.toString() + "<<<<<<<<<<<<<<<   responde");
        print(response.statusCode.toString() + "<<<<<<<<<<<<<<<   responde");
        if (response.success) {
          setState(() {
            _loading = false;
          });
          Get.to(
            Clin(),
          );
        } else {
          setState(() {
            _loading = false;
          });
          if (response.errType == 0) {
            // network error
            showNetworkErrorDialog(context, () {
              Get.back();
            });
          } else if (response.errType == 1) {
            // error from server
            print(response.error.toString());
            if (response.statusCode == 401 || response.statusCode == 422) {
              Toast.show(response.error['message'], context,
                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
            }
          } else {
            // other error
            Toast.show(response.error['message'], context,
                gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: AppTheme.authMainDecoration,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                authLogo(
                    context: context,
                    welcomeMessage: translator.currentLanguage == "en"
                        ? "Welcome back again"
                        : "مرحبا بعدودتك مرة اخرى",
                    title: translator.currentLanguage == "en"
                        ? "Please login to your account"
                        : "من فضلك قم بتسجيل الدخول لحسابك"),
                txtField(
                    context: context,
                    controller: null,
                    enabled: true,
//                  hintText: translator.currentLanguage == "en"
//                      ? "Email/mobile"
//                      : "البريد الالكترونى/رقم الجوال",
//                  textInputType: TextInputType.text,
                    hintText: translator.currentLanguage == "en"
                        ? "mobile"
                        : "ارقم الجوال",
                    textInputType: TextInputType.phone,
                    validator: (String val) {
                      if (val.isEmpty)
                        return translator.currentLanguage == "en"
                            ? "Mobile number is required"
                            : "رقم الجوال مطلوب";
                      else
                        return null;
                    },
                    onSaved: (String val) {
                      setState(() {
                        mobile = val;
                      });
                    },
                    obscureText: false,
                    prefix: "assets/icons/phone.png"),
                SizedBox(
                  height: AppTheme.sizedBoxHeight,
                ),
                txtField(
                    context: context,
                    validator: (String val) {
                      if (val.isEmpty)
                        return translator.currentLanguage == "en"
                            ? "Password is required"
                            : "كلمة المرور مطلوبة";
                      else
                        return null;
                    },
                    onSaved: (String val) {
                      setState(() {
                        password = val;
                      });
                    },
                    controller: null,
                    textInputType: TextInputType.visiblePassword,
                    enabled: true,
                    prefix: "assets/icons/password.png",
                    obscureText: obscureText,
                    hintText: translator.currentLanguage == "en"
                        ? "Password"
                        : "كلمة المرور"),
                SizedBox(
                  height: AppTheme.sizedBoxHeight,
                ),
                forgetPasswordText(context, () {
                  Get.to(
                    ForgetPasswordView(
                      type: "client",
                    ),
                  );
                }),
                _loading
                    ? authLoader()
                    : btn(
                        context,
                        translator.currentLanguage == "en"
                            ? "Sign in"
                            : "تسجيل الدخوال", () {
                        _submit(context);
                      }),
                InkWell(
                  onTap: () {
                    Get.to(
                      Clin(),
                    );
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
                SizedBox(
                  height: 50,
                ),
                createNewAccount(context, () {
                  Get.to(ClientSingUp());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool obscureText = true;
}
