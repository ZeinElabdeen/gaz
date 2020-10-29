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
import 'package:master/Screens/Mutual/Auth/ForgetPassword/controller.dart';
import 'package:master/Screens/Mutual/Auth/ForgetPaswordActivation/view.dart';
import 'package:toast/toast.dart';

class ForgetPasswordView extends StatefulWidget {
  final String type;

  const ForgetPasswordView({Key key, this.type}) : super(key: key);
  @override
  _ForgetPasswordViewState createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  void _clientSubmitted() async {
    if (!_formKey.currentState.validate())
      return;
    else {
      setState(() {
        _loading = true;
      });
      _formKey.currentState.save();
      CustomResponse response = await _controller.client(phone: mobile);
      if (response.success) {
        print(response.response.data.toString() + "<<<<<<<<<<<<<");
        Get.to(ForgetPasswordActivationView(
          code: response.response.data["data"].toString(),
          mobile: mobile,
          type: widget.type,
        ));
        setState(() {
          _loading = false;
        });
      } else {
        Toast.show(
            translator.currentLanguage == "en"
                ? "Please enter valid number"
                : "من فضلك أدخل رقم صحيح",
            context,
            gravity: Toast.CENTER,
            duration: Toast.LENGTH_LONG);
//        Toast.show(response.response.data["message"].toString(), context,
//            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        setState(() {
          _loading = false;
        });
      }
    }
  }

  String mobile;
  bool _loading = false;
  ForgetPasswordController _controller = ForgetPasswordController();

  void _providerSubmitted() async {
    if (!_formKey.currentState.validate())
      return;
    else {
      setState(() {
        _loading = true;
      });
      _formKey.currentState.save();

      CustomResponse response = await _controller.provider(phone: mobile);
      print(response.response.data.toString() + "<<<<<<<<<<<<<<<<<<< respons");
      if (response.success) {
        setState(() {
          _loading = false;
        });
        Get.to(ForgetPasswordActivationView(
          code: response.response.data["data"].toString(),
          mobile: mobile,
          type: widget.type,
        ));
      } else {
        setState(() {
          _loading = false;
        });
        Toast.show(response.response.data["message"].toString(), context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      }
    }
  }

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
                        : "نسيت كلمة المرور",
                    title: translator.currentLanguage == "en"
                        ? "Please enter your mobile to receive code"
                        : "من فضلك قم بادخال رقم الاجوال لارسال الكود"),
                txtField(
                    context: context,
                    controller: null,
                    enabled: true,
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
                    prefix: "assets/icons/user.png"),
                SizedBox(
                  height: AppTheme.sizedBoxHeight,
                ),
                _loading
                    ? authLoader()
                    : Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 30),
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
