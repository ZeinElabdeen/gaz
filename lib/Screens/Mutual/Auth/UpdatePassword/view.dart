import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/Btns.dart';
import 'package:master/Helpers/CustomWidgets/NetworkDialog.dart';
import 'package:master/Helpers/CustomWidgets/TextFormFields.dart';
import 'package:master/Helpers/Loaders.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/appBar.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:toast/toast.dart';

import 'controller.dart';

class UpdatePasswordView extends StatefulWidget {
  final String type;

  const UpdatePasswordView({Key key, this.type}) : super(key: key);
  @override
  _UpdatePasswordViewState createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  bool obscureText = true;
  String oldPassword, newPassword;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double sizedBoxHeight = 15.0;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  UpdatePasswordController _controller = UpdatePasswordController();
  bool _loading = false;
  void _submit() async {
    if (!_formKey.currentState.validate())
      return;
    else {
      setState(() {
        _loading = true;
      });
      _formKey.currentState.save();
      CustomResponse response = await _controller.postData(
        urlType: widget.type == "client" ? "client" : "driver",
        oldPassword: oldPassword,
        newPassword: newPassword,
        passwordConfirmation: newPassword,
      );
      if (response.success) {
        //print(
        //   response.response.data.toString() + "<<<<<<<<<<<<<<<<<<<<<<<<<<  ");
        // print(response.statusCode.toString() + "<<<<<<<<<<<<<<<<<<<<<<<<<<  ");
        setState(() {
          _loading = false;
        });
        Toast.show(
            translator.currentLanguage == "en"
                ? "Password changed successfully"
                : "تم تغير كلمة المرور بنجاح",
            context,
            gravity: Toast.CENTER,
            duration: Toast.LENGTH_LONG);
        _formKey.currentState.reset();
        Get.back();
      } else if (response.errType == 0) {
        setState(() {
          _loading = false;
        });
        showNetworkErrorDialog(context, () {
          Get.back();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translator.currentLanguage == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.backGroundColor,
        appBar: appBar(
            context: context,
            title: translator.currentLanguage == "en"
                ? "Update password"
                : "تعديل كلمة المرور",
            leading: true),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 50),
                child: Image.asset(
                  "assets/icons/logo.png",
                  width: MediaQuery.of(context).size.width * .3,
                  height: MediaQuery.of(context).size.width * .3,
                ),
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
                      oldPassword = val;
                    });
                  },
                  controller: null,
                  textInputType: TextInputType.visiblePassword,
                  enabled: true,
                  prefix: "assets/icons/password.png",
                  obscureText: obscureText,
                  hintText: translator.currentLanguage == "en"
                      ? "Old Password"
                      : "كلمة المرور القديمة"),
              SizedBox(
                height: AppTheme.sizedBoxHeight,
              ),
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
                  onSaved: (String val) {
                    setState(() {
                      newPassword = val;
                    });
                  },
                  controller: _passwordController,
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
                    else if (val.toString().length < 6) {
                      return translator.currentLanguage == "en"
                          ? "It must contain at least 6 numbers or letters"
                          : "يجب ان تحتوي علي 6 ارقام او احرف علي الأقل";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String val) {
                    setState(() {
                      newPassword = val;
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
              SizedBox(
                height: AppTheme.sizedBoxHeight,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80, bottom: 30),
                child: _loading
                    ? authLoader()
                    : btn(context,
                        translator.currentLanguage == "en" ? "Edit" : "تعديل",
                        () {
                        _submit();
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
