import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/Btns.dart';
import 'package:master/Helpers/CustomWidgets/ImagePicker.dart';
import 'package:master/Helpers/CustomWidgets/TextFormFields.dart';
import 'package:master/Helpers/Loaders.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/appBar.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Screens/Mutual/MainCategories/Controller.dart';
import 'package:master/Screens/Mutual/MainCategories/Models/Citites.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'controller.dart';

class ClientUpdateProfileView extends StatefulWidget {
  @override
  _ClientUpdateProfileViewState createState() =>
      _ClientUpdateProfileViewState();
}

class _ClientUpdateProfileViewState extends State<ClientUpdateProfileView> {
  String name, mobile, city, profile, token, email;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  _getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      _nameController.text = name;
      mobile = prefs.getString('mobile');
      _mobileController.text = mobile;
      city = prefs.getString('city');
      email = prefs.getString('email');
      _emailController.text = email;
      profile = prefs.getString('profile');
      token = prefs.getString('token');
      cityId = prefs.getInt('cityId');

      print(token + "           0000000000000000000000000000");
    });
  }

  double sizedBoxHeight = 15.0;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ClientUpdateProfileController _controller = ClientUpdateProfileController();
  bool _loading = false;
  void _submit() async {
    if (!_formKey.currentState.validate())
      return;
    else {
      setState(() {
        _loading = true;
      });
      _formKey.currentState.save();

      CustomResponse response = await _controller.updateProfile(
          phone: mobile,
          cityId: cityId,
          email: email,
          name: name,
          img: profileImage);
      print(response.response.toString() + "<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
      print(response.statusCode.toString() + "<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
      if (response.success) {
        setState(() {
          _loading = false;
        });
        Get.back();
        Toast.show(
            translator.currentLanguage == "en"
                ? "Your data updated successfully"
                : "تم تعديل بياناتك بنجاح",
            context,
            gravity: Toast.CENTER);
      } else if (response.statusCode == 422 || response.statusCode == 401) {
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
        Toast.show(response.error["message"].toString(), context,
            gravity: Toast.CENTER);
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    _getData();
    _getCities();
    profile = AppTheme.defaultImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backGroundColor,
      appBar: appBar(
          context: context,
          title: translator.currentLanguage == "en"
              ? "Update profile"
              : "تعديل بياناتى",
          leading: true),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _profilePicture(),
            txtField(
                context: context,
                controller: _nameController,
                hintText: translator.currentLanguage == "en"
                    ? "Full user name"
                    : "اسم المستخدم كاملا",
                textInputType: TextInputType.text,
                validator: (String val) {
                  if (val.isEmpty)
                    return translator.currentLanguage == "en"
                        ? "User name is required"
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
                prefix: "assets/icons/user.png"),
            SizedBox(
              height: AppTheme.sizedBoxHeight,
            ),
            txtField(
                context: context,
                controller: _emailController,
                enabled: true,
                hintText: translator.currentLanguage == "en"
                    ? "Email"
                    : "البريد الالكترونى",
                textInputType: TextInputType.emailAddress,
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
                prefix: "assets/icons/mail.png"),
            SizedBox(
              height: AppTheme.sizedBoxHeight,
            ),
            txtField(
                context: context,
                controller: _mobileController,
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
                    mobile = val;
                  });
                },
                obscureText: false,
                prefix: "assets/icons/phone.png"),
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
                        hintText: cityName == null ? city : cityName,

                        // translator.currentLanguage == "en" ? "City" : "المدينة",
                        textInputType: TextInputType.text,
                        validator: (val) {},
                        onSaved: (val) {},
                        enabled: false,
                        obscureText: false,
                        prefix: "assets/icons/browser.png"),
                  ),
            SizedBox(
              height: sizedBoxHeight * 3,
            ),
            _loading
                ? loader()
                : btn(context,
                    translator.currentLanguage == "en" ? "Edit" : "تعديل", () {
                    _submit();
                  }),
          ],
        ),
      ),
    );
  }

  dynamic profileImage;
  void _getProfilePic(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image) {
      if (image != null) {
        setState(() {
          profileImage = image;
        });
      }
      Navigator.pop(context);
    });
  }

  Widget _profilePicture() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 40),
      child: Center(
        child: InkWell(
          onTap: () {
            openImagePicker(
                context: context,
                onCameraTapped: () {
                  _getProfilePic(context, ImageSource.camera);
                },
                onGalleryTapped: () {
                  _getProfilePic(context, ImageSource.gallery);
                });
          },
          child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: .1),
                image: DecorationImage(
                    image: profileImage is File
                        ? FileImage(profileImage)
                        : NetworkImage(profile),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(
                  Radius.circular(60),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.camera_alt,
                  size: 30,
                  color: Colors.grey,
                ),
              )),
        ),
      ),
    );
  }

  // ======>>> cities
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
//*********
}
