import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/AuthWidgets/logo.dart';
import 'package:master/Helpers/CustomWidgets/Btns.dart';
import 'package:master/Helpers/CustomWidgets/TextFormFields.dart';
import 'package:master/Helpers/Loaders.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Screens/Mutual/Auth/ResetPassword/controller.dart';
import 'package:master/Screens/Mutual/loginType/view.dart';
import 'package:toast/toast.dart';

class ResetPasswordView extends StatefulWidget {
  final String type;
  final String mobile;
  final String code;

  const ResetPasswordView({Key key, this.type, this.mobile, this.code})
      : super(key: key);
  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  ResetPasswordController _controller = ResetPasswordController();
  void _clientSubmitted() async {
    if (!_formKey.currentState.validate())
      return;
    else {
      setState(() {
        _loading = true;
      });
      _formKey.currentState.save();
      CustomResponse response = await _controller.client(
          phone: widget.mobile,
          code: widget.code,
          password: password,
          passwordConfirmation: password);
      // print(response.statusCode.toString() +"<<<<<<<<<<<<<<<< status code");
      if (response.success) {
        //     print(response.response.data.toString() +"<<<<<<<<<<<<<<<<<< data");
        setState(() {
          _loading = false;
        });
        Toast.show(
            translator.currentLanguage == "en"
                ? "Password recovered successfully"
                : "تم استعادة كلمة المرور بنجاح",
            context,
            gravity: Toast.CENTER,
            duration: Toast.LENGTH_LONG);

        Get.to(
          LoginTypeView(),
        );
      }
    }
  }

  bool _loading = false;
  void _providerSubmitted() async {
    if (!_formKey.currentState.validate())
      return;
    else {
      setState(() {
        _loading = true;
      });
      _formKey.currentState.save();
      CustomResponse response = await _controller.provider(
          phone: widget.mobile,
          code: widget.code,
          password: password,
          passwordConfirmation: password);
      if (response.success) {
        Toast.show(
            translator.currentLanguage == "en"
                ? "Password recovered successfully"
                : "تم استعادة كلمة المرور بنجاح",
            context,
            gravity: Toast.CENTER,
            duration: Toast.LENGTH_LONG);
        setState(() {
          _loading = false;
        });
        Get.to(
          LoginTypeView(),
        );
      }
    }
  }

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                        ? "Reset password"
                        : "اعادة ضبط كلمة المرور",
                    title: translator.currentLanguage == "en"
                        ? "Please enter new password"
                        : "قم بادخال كلمة المرور الجديدة"),
                txtField(
                    context: context,
                    validator: (String val) {
                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        // print("not equal $password");
                        return translator.currentLanguage == "en"
                            ? "Please check password"
                            : "من فضلك تأكد من كلمه المرور";
                      } else if (val.toString().length < 6) {
                        return translator.currentLanguage == "en"
                            ? "It must contain at least 6 numbers or letters"
                            : "يجب ان تحتوي علي 6 ارقام او احرف علي الأقل";
                      } else if (val.isEmpty)
                        return translator.currentLanguage == "en"
                            ? "Password is required"
                            : "كلمة المرور مطلوبة";
                      else {
                        return null;
                      }
                    },
                    controller: _passwordController,
                    onSaved: (String val) {
                      setState(() {
                        password = val;
                      });
                    },
                    textInputType: TextInputType.visiblePassword,
                    enabled: true,
                    prefix: "assets/icons/password.png",
                    obscureText: obscureText,
                    hintText: translator.currentLanguage == "en"
                        ? "New password"
                        : "كلمة المرور الجديدة"),
                SizedBox(
                  height: AppTheme.sizedBoxHeight,
                ),
                txtField(
                    context: context,
                    validator: (String val) {
                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        return translator.currentLanguage == "en"
                            ? "Please check password"
                            : "من فضلك تأكد من كلمه المرور";
                      } else if (val.isEmpty)
                        return translator.currentLanguage == "en"
                            ? "Password is required"
                            : "كلمة المرور مطلوبة";
                      else {
                        return null;
                      }
                    },
                    onSaved: (String val) {
                      setState(() {
                        password = val;
                      });
                    },
                    controller: _confirmPasswordController,
                    textInputType: TextInputType.visiblePassword,
                    enabled: true,
                    prefix: "assets/icons/password.png",
                    obscureText: obscureText,
                    hintText: translator.currentLanguage == "en"
                        ? "Confirm new password"
                        : "تأكيد كلمة المرور الجديدة"),
                _loading
                    ? authLoader()
                    : Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 20),
                        child: btn(
                            context,
                            translator.currentLanguage == "en"
                                ? "Send"
                                : "ارسال", () {
                          widget.type == "client"
                              ? _clientSubmitted()
                              : _providerSubmitted();
                        }),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String password;
  bool obscureText = true;
}
