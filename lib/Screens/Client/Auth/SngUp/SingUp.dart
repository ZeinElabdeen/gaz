import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/AuthWidgets/AlreadyHaveAccount.dart';
import 'package:master/Helpers/CustomWidgets/AuthWidgets/logo.dart';
import 'package:master/Helpers/CustomWidgets/Btns.dart';
import 'package:master/Helpers/CustomWidgets/TextFormFields.dart';
import 'package:master/Helpers/Loaders.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Screens/Client/Auth/SngUp/controller.dart';
import 'package:master/Screens/Mutual/Auth/AccountActivation/view.dart';
import 'package:master/Screens/Mutual/MainCategories/Controller.dart';
import 'package:master/Screens/Mutual/MainCategories/Models/Citites.dart';
import 'package:toast/toast.dart';

class ClientSingUp extends StatefulWidget {
  @override
  _ClientSingUpState createState() => _ClientSingUpState();
}

class _ClientSingUpState extends State<ClientSingUp> {
  bool _loading = false;

  @override
  void initState() {
    _getCities();
    super.initState();
  }

  ClientSignUpController _clientSignUpController = ClientSignUpController();
  String name, email, phone, password;
  void _submit(BuildContext context) {
    if (!_formKey.currentState.validate())
      return;
    else if (cityId == null) {
      print("8999999999999999999999");
      Toast.show(
          translator.currentLanguage == "en"
              ? "City is required"
              : "المدينة مطلوبة",
          context,
          gravity: Toast.CENTER);
    } else {
      _formKey.currentState.save();
      setState(() {
        _loading = true;
      });

      _clientSignUpController
          .userRegister(
        name: name,
        phone: phone,
        cityId: cityId,
        password: password,
        email: email,
      )
          .then((response) {
        if (response.success) {
          setState(() {
            _loading = false;
          });

          Toast.show(response.response.data['message'], context,
              gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
          Get.to(
            AccountActivationView(
              type: "client",
              code: response.response.data['date'].toString(),
              mobile: phone,
            ),
          );
        } else {
          setState(() {
            _loading = false;
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
            if (response.statusCode == 422 || response.statusCode == 401) {
              List<String> errorList = [];
              response.error["errors"].forEach((key, value) {
                errorList.add(value[0]);
              });

              Toast.show(errorList[0], context,
                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);

              setState(() {
                _loading = false;
              });
            } else {
              Toast.show(response.error['message'], context,
                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
            }
          } else {
            // other error
            Toast.show(response.error['message'], context,
                gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
            setState(() {
              _loading = false;
            });
          }
        }
      });
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            decoration: AppTheme.authMainDecoration,
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                authLogo(
                  context: context,
                  welcomeMessage:
                      translator.currentLanguage == "en" ? "Welcome" : "مرحبا",
                  title: translator.currentLanguage == "en"
                      ? "Please fill your account info"
                      : "قم بتسجيل بينات حسابك",
                ),
                txtField(
                  context: context,
                  controller: null,
                  hintText: translator.currentLanguage == "en"
                      ? "Full user name"
                      : "اسم المستخدم كاملا",
                  textInputType: TextInputType.text,
                  validator: (String val) {
                    if (val.isEmpty)
                      return translator.currentLanguage == "en"
                          ? "User name is requred"
                          : "اسم المستخدم مطلوب";
                    else
                      return null;
                  },
                  onSaved: (String val) {
                    setState(() {
                      name = val;
                    });
                  },
                  obscureText: false,
                  enabled: true,
                  prefix: "assets/icons/user.png",
                ),
                SizedBox(
                  height: AppTheme.sizedBoxHeight,
                ),
                txtField(
                  context: context,
                  controller: null,
                  enabled: true,
                  hintText: translator.currentLanguage == "en"
                      ? "Email"
                      : "البريد الالكتروني",
                  validator: (String val) {
                    Pattern pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);

                    if (val.isEmpty) {
                      return translator.currentLanguage == "en"
                          ? "Email is required"
                          : "البريد الالكترونى  مطلوب";
                    } else if (!regex.hasMatch(val.trim()))
                      return translator.currentLanguage == "en"
                          ? "Enter a valid email"
                          : "ادخل بريد الكتروني صحيح";
                    else
                      return null;
                  },
                  onSaved: (String val) {
                    setState(() {
                      email = val;
                    });
                  },
                  obscureText: false,
                  prefix: "assets/icons/mail.png",
                ),
                SizedBox(
                  height: AppTheme.sizedBoxHeight,
                ),
                txtField(
                  context: context,
                  controller: null,
                  enabled: true,
                  hintText: translator.currentLanguage == "en"
                      ? "Mobile number"
                      : "رقم الجوال",
                  textInputType: TextInputType.phone,
                  validator: (String val) {
                    if (val.isEmpty)
                      return translator.currentLanguage == "en"
                          ? "Mobile number is required"
                          : "رقم الجوال مطلوب";
                    else if (val.toString().length < 10) {
                      return translator.currentLanguage == "en"
                          ? "Mobile must contain at least 10 numbers"
                          : "يجب ان يحتوي علي 10 ارقام على الأقل";
                    } else
                      return null;
                  },
                  onSaved: (String val) {
                    setState(() {
                      phone = val;
                    });
                  },
                  obscureText: false,
                  prefix: "assets/icons/phone.png",
                ),
                SizedBox(
                  height: AppTheme.sizedBoxHeight,
                ),
                citiesLoading
                    ? authLoader()
                    : InkWell(
                        onTap: () {
                          _openCitiesBottomSheet();
                        },
                        child: txtField(
                            context: context,
                            controller: null,
                            hintText: cityName != null
                                ? cityName
                                : translator.currentLanguage == "en"
                                    ? "City"
                                    : "المدينة",
                            textInputType: TextInputType.text,
                            validator: (val) {},
                            onSaved: (val) {},
                            enabled: false,
                            obscureText: false,
                            prefix: "assets/icons/browser.png"),
                      ),
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
                  onSaved: null,
                  controller: _passwordController,
                  textInputType: TextInputType.visiblePassword,
                  enabled: true,
                  prefix: "assets/icons/password.png",
                  obscureText: obscureText,
                  hintText: translator.currentLanguage == "en"
                      ? "Password"
                      : "كلمة المرور",
                ),
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
                      ? "Confirm password"
                      : "تأكيد كلمة المرور",
                ),
                _loading
                    ? authLoader()
                    : btn(
                        context,
                        translator.currentLanguage == "en"
                            ? "Register"
                            : "تسجيل", () {
                        _submit(context);
                      }),
                alreadyHaveAccount(context, () {
                  Get.back();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getCities() async {
    CustomResponse response = await _mainCategoryController.getCities();
    if (response.success) {
      setState(() {
        _citiesModel = CitiesModel.fromJson(response.response.data);
        _cityItems = _citiesModel.data;
        citiesLoading = false;
      });
    }
  }

  CitiesData citiesData = CitiesData();
  List<CitiesData> _cityItems = [];
  String cityName;
  int cityId;
  bool citiesLoading = true;
  void _openCitiesBottomSheet() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * .6,
            child: CupertinoActionSheet(
              cancelButton: CupertinoButton(
                child: Text(
                  translator.currentLanguage == "en" ? "City" : "المدينة",
                  style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: _cityItems
                  .map(
                    (item) => CupertinoButton(
                      child: Center(
                        child: Text(
                          item.name ?? "",
                          style: TextStyle(
                              fontFamily: AppTheme.fontName,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          cityName = item.name;
                          cityId = item.id;
                          citiesData = item;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        });
  }

  CitiesModel _citiesModel = CitiesModel();
  MainCategoryController _mainCategoryController = MainCategoryController();
//*********
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool obscureText = true;
}
