import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/Loaders.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/appBar.dart';
import 'package:master/Helpers/app_theme.dart';

import 'controller.dart';
import 'model.dart';

class AboutAppView extends StatefulWidget {
  @override
  _AboutAppViewState createState() => _AboutAppViewState();
}

class _AboutAppViewState extends State<AboutAppView> {
  AppInfoController _controller = AppInfoController();
  AppInfoModel _model = AppInfoModel();
  bool _loading = true;
  void _getData() async {
    CustomResponse response = await _controller.gatAppInfo(url: "about");
    if (response.success) {
      setState(() {
        _model = AppInfoModel.fromJson(response.response.data);

        _loading = false;
      });
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          context: context,
          leading: true,
          title:
              translator.currentLanguage == "en" ? "About app" : "عن التطبيق"),
      body: _loading
          ? loader()
          : Directionality(
              textDirection: translator.currentLanguage == "en"
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 20),
                    child: Text(
                      _model.data,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.secondaryColor,
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
