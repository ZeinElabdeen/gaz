import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/Loaders.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/appBar.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Screens/Mutual/ContatctUs/controller.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

import 'model.dart';

class ContactUsView extends StatefulWidget {
  @override
  _ContactUsViewState createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  ContactUsModel _model = ContactUsModel();
  ContactUsController _controller = ContactUsController();
  bool _loading = true;
  void _getData() async {
    CustomResponse response = await _controller.getData();
    if (response.success) {
      setState(() {
        _model = ContactUsModel.fromJson(response.response.data);
        _loading = false;
      });
    }
  }

  String facebookUrl;
  _launchFaceBook(String link) async {
    facebookUrl = link;
    if (await canLaunch(facebookUrl)) {
      await launch(facebookUrl);
    } else {
      throw 'Could not launch $facebookUrl';
    }
  }

  String instagramUrl;
  _launchInsta(String link) async {
    instagramUrl = link;
    if (await canLaunch(instagramUrl)) {
      await launch(instagramUrl);
    } else {
      throw 'Could not launch $instagramUrl';
    }
  }

  String twitterLink;
  _launchTwitter(String link) async {
    twitterLink = link;
    if (await canLaunch(twitterLink)) {
      await launch(twitterLink);
    } else {
      throw 'Could not launch $twitterLink';
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
              translator.currentLanguage == "en" ? "Contact us" : "اتصل بنا"),
      body: _loading
          ? loader()
          : Directionality(
              textDirection: translator.currentLanguage == "en"
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      translator.currentLanguage == "en"
                          ? "Need help ??"
                          : "تحتاج الي مساعده ؟؟",
                      style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          fontFamily: AppTheme.boldFont),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      translator.currentLanguage == "en"
                          ? "Contact us via "
                          : "تواصل معنا عبر",
                      style: TextStyle(color: AppTheme.secondaryColor),
                    ),
                  ),
                  _item(
                      context: context,
                      txt: _model.data.whatsapp,
                      onTap: () {
                        FlutterOpenWhatsapp.sendSingleMessage(
                            _model.data.whatsapp, "welcome");
                      },
                      img: "assets/icons/whats_contact.png"),
                  _item(
                      context: context,
                      txt: _model.data.phone,
                      onTap: () {
                        UrlLauncher.launch('tel:+${_model.data.phone}');
                      },
                      img: "assets/icons/phone_contact.png"),
                  _item(
                      context: context,
                      txt: _model.data.email,
                      onTap: () {},
                      img: "assets/icons/message_contact.png"),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _avatarItem(
                          context: context,
                          onTap: () {
                            _launchFaceBook(_model.data.facebook);
                          },
                          img: "assets/icons/facebook.png"),
                      _avatarItem(
                          context: context,
                          onTap: () {
                            _launchTwitter(_model.data.twitter);
                          },
                          img: "assets/icons/twitter.png"),
                      _avatarItem(
                          context: context,
                          onTap: () {
                            _launchInsta(_model.data.instgram);
                          },
                          img: "assets/icons/insta.png"),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  _item({BuildContext context, Function onTap, String img, String txt}) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12, top: 10),
      child: Material(
        elevation: 3,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppTheme.thirdColor,
                      border:
                          Border.all(width: 2, color: AppTheme.primaryColor),
                      image: DecorationImage(
                        image: AssetImage(
                          img,
                        ),
                        fit: BoxFit.contain,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                Text(
                  txt,
                  style: TextStyle(color: AppTheme.primaryColor, fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _avatarItem({BuildContext context, String img, Function onTap}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: AppTheme.thirdColor,
            border: Border.all(width: 2, color: AppTheme.primaryColor),
            image: DecorationImage(
              image: AssetImage(
                img,
              ),
              fit: BoxFit.contain,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
      ),
    );
  }
}
