import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/AuthWidgets/logo.dart';
import 'package:master/Helpers/CustomWidgets/Btns.dart';
import 'package:master/Helpers/CustomWidgets/Text.dart';
import 'package:master/Helpers/Loaders.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Screens/Client/Clien.dart';
import 'package:master/Screens/Provider/Provider.dart';
import 'package:toast/toast.dart';
import '../PinLength.dart';
import 'controller.dart';

class AccountActivationView extends StatefulWidget {
  final String type, code, mobile;
  const AccountActivationView({Key key, this.type, this.code, this.mobile})
      : super(key: key);
  @override
  _AccountActivationViewState createState() => _AccountActivationViewState();
}

class _AccountActivationViewState extends State<AccountActivationView> {
  TextEditingController code = TextEditingController();
  AccountActivationController _controller = AccountActivationController();
  bool _clientLoading = false;
  void _clientSubmitted() {
    if (code.text.isEmpty) {
      Toast.show(
          translator.currentLanguage == "en"
              ? "Please enter the code"
              : "قم بادخال الكود",
          context,
          gravity: Toast.CENTER);
    } else {
      setState(() {
        _clientLoading = true;
      });
      _controller
          .clientAccountActivation(code: code.text, phone: widget.mobile)
          .then((response) {
        if (response.success) {
          setState(() {
            _clientLoading = false;
          });
          Toast.show(response.response.data["message"], context,
              gravity: Toast.CENTER);
          Get.to(
            Clin(),
          );
        } else {
          setState(() {
            _clientLoading = false;
          });
          if (response.errType == 0) {
            // network error
            Toast.show(
                translator.currentLanguage == "ar"
                    ? "من فضلك تاكد من الاتصال بالانترنت"
                    : "PLEASE CHECK YOUR NETWORK CONNECTION",
                context,
                gravity: Toast.CENTER,
                duration: Toast.LENGTH_LONG);
          } else if (response.errType == 1) {
            // error from server
            print(response.error.toString());
            if (response.statusCode == 401) {
              Toast.show(response.error['message'], context,
                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
            }
          } else {
            // other error
            Toast.show(response.error['message'], context,
                gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
            setState(() {
              _providerLoading = false;
            });
          }
        }
      });
    }
  }

  bool _providerLoading = false;
  void _providerSubmitted() {
    if (code.text.isEmpty) {
      Toast.show(
          translator.currentLanguage == "en"
              ? "Please enter the code"
              : "قم بادخال الكود",
          context,
          gravity: Toast.CENTER);
    } else {
      setState(() {
        _providerLoading = true;
      });
      _controller
          .providerAccountActivation(code: code.text, phone: widget.mobile)
          .then((response) {
        print(response.statusCode.toString() + "   <<<<<<<<<<<<<< status code");
        if (response.success) {
          setState(() {
            _providerLoading = false;
          });
          Toast.show(response.response.data["message"], context,
              gravity: Toast.CENTER);
          Get.offAll(
            Provider(),
          );
        } else {
          setState(() {
            _providerLoading = false;
          });
          if (response.errType == 0) {
            // network error
            Toast.show(
                translator.currentLanguage == "ar"
                    ? "من فضلك تاكد من الاتصال بالانترنت"
                    : "PLEASE CHECK YOUR NETWORK CONNECTION",
                context,
                gravity: Toast.CENTER,
                duration: Toast.LENGTH_LONG);
          } else if (response.errType == 1) {
            // error from server
            Toast.show(
                translator.currentLanguage == "en"
                    ? "Code is wrong"
                    : "الكود غير صحيح",
                context,
                gravity: Toast.CENTER,
                duration: Toast.LENGTH_LONG);

//            if (response.statusCode == 401) {
//              Toast.show(response.error['message'], context,
//                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
//            }
          } else {
            // other error
            Toast.show(
                translator.currentLanguage == "en"
                    ? "Code is wrong"
                    : "الكود غير صحيح",
                context,
                gravity: Toast.CENTER,
                duration: Toast.LENGTH_LONG);
            setState(() {
              _providerLoading = false;
            });
          }
        }
      });
    }
  }

  bool _resendCodeLoading = false;
  void _resendClientCode() async {
    setState(() {
      _resendCodeLoading = true;
    });
    CustomResponse response =
        await _controller.resendClientCode(phone: widget.mobile);

    if (response.success) {
      print(response.response.toString() + "<<<<<<<<<<<<<<<<<<<<<<<< response");

      setState(() {
        _resendCodeLoading = false;
        stop = false;
      });
      _startCountDown();
    }
  }

  void _resendProviderCode() async {
    setState(() {
      _resendCodeLoading = true;
    });
    CustomResponse response =
        await _controller.resendProviderCode(phone: widget.mobile);

    if (response.success) {
      print(response.response.toString() + "<<<<<<<<<<<<<<<<<<<<<<<< response");
      setState(() {
        _resendCodeLoading = false;
        stop = false;
      });
      _startCountDown();
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Timer timer;
  int hours;
  int minutes;
  int seconds;
  int endDate;
  bool stop = false;
  void _startCountDown() {
    print("timer started");
    DateTime now = new DateTime.now();
    int endDate = now.add(Duration(minutes: 1)).toUtc().millisecondsSinceEpoch;
    timer = Timer.periodic(Duration(milliseconds: 1000), (Timer t) {
      var now = DateTime.now().toUtc().millisecondsSinceEpoch;
      var distance = endDate - now;
      Duration remaining = Duration(milliseconds: endDate - now);

      setState(() {
        hours = remaining.inHours;
        minutes = DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds)
            .minute;
        seconds = DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds)
            .second;
      });
      // print("$hours $minutes $seconds");

      if (distance <= 0) {
        timer.cancel();
        stop = true;
        print('finish');
      }
    });
  }

  @override
  void initState() {
    _startCountDown();
    super.initState();
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
                      ? "Your info registered successfully"
                      : "لقد تم تسجيل بيناناتك بنجاح",
                  title: translator.currentLanguage == "en"
                      ? "Please enter code that sent to your mobile"
                      : "قم بادخال الكود المكون من 4 أرقام المرسل على رقم هاتفك"),
              pinLength(context: context, onChange: (val) {}, controller: code),
              Text(
                "تستطيع اعادة ارسال الكود بعد",
                style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 20),
                child: Text(
                  stop ? "00:00" : "${minutes ?? 01}:${seconds ?? 00}",
                  style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              stop
                  ? _resendCodeLoading
                      ? loader()
                      : InkWell(
                          onTap: () {
                            widget.type == "client"
                                ? _resendClientCode()
                                : _resendProviderCode();
                          },
                          child: titleText(translator.currentLanguage == "en"
                              ? "Resend code"
                              : "ارسال مرة اخرى"),
                        )
                  : Container(),
              _clientLoading || _providerLoading
                  ? authLoader()
                  : btn(
                      context,
                      translator.currentLanguage == "en"
                          ? "Activate account"
                          : "تفعيل الحساب", () {
                      widget.type == "client"
                          ? _clientSubmitted()
                          : _providerSubmitted();
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
