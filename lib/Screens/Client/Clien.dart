import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Helpers/colors.dart';

import 'Cart/view.dart';
import 'Home/view.dart';
import 'More/view.dart';
import 'MyOrder/view.dart';

class Clin extends StatefulWidget {
  final int pageIndex;
  const Clin({Key key, this.pageIndex}) : super(key: key);
  @override
  _ClinState createState() => _ClinState();
}

class _ClinState extends State<Clin> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  var pages = [
    ClientHomeView(),
    ClientOrdersView(),
    ClientCartView(),
    ClientMoreView(),
  ];
  Future<bool> _onBackPressed() {
    return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: new Text(
              translator.currentLanguage == 'ar'
                  ? "هل تريد اغلاق التطبيق "
                  : "Do you want close the app?",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryColor,
                  fontFamily: AppTheme.fontName),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  translator.currentLanguage == 'ar' ? "لا" : "No",
                  style: TextStyle(color: AppTheme.secondaryColor),
                ),
              ),
              new FlatButton(
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: new Text(
                  translator.currentLanguage == 'ar' ? "نعم" : "ok",
                  style: TextStyle(color: AppTheme.secondaryColor),
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    if (widget.pageIndex != null) {
      setState(() {
        _selectedIndex = widget.pageIndex;
      });
    } else {
      setState(() {
        _selectedIndex = 0;
      });
    }
    super.initState();
  }

  static const _txtStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Directionality(
        textDirection: translator.currentLanguage == 'en'
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Scaffold(
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  title: Text(
                    translator.currentLanguage == "en" ? "Home" : "الرئيسية",
                    style: _txtStyle,
                  ),
                  activeIcon: Image.asset(
                    'assets/icons/home.png',
                    height: 20,
                    color: AppTheme.primaryColor,
                  ),
                  icon: Image.asset(
                    'assets/icons/home.png',
                    height: 20,
                    color: Color(getColorHexFromStr('#D6DBE6')),
                  ),
                ),
                BottomNavigationBarItem(
                  title: Text(
                    translator.currentLanguage == "en" ? "My orders" : "طلباتى",
                    style: _txtStyle,
                  ),
                  activeIcon: Image.asset(
                    'assets/icons/orders_a.png',
                    height: 20,
                    color: AppTheme.primaryColor,
                  ),
                  icon: Image.asset(
                    'assets/icons/orders_in.png',
                    height: 20,
                    color: Color(getColorHexFromStr('#D6DBE6')),
                  ),
                ),
                BottomNavigationBarItem(
                  title: Text(
                    translator.currentLanguage == "en" ? "Cart" : "السلة",
                    style: _txtStyle,
                  ),
                  activeIcon: Image.asset(
                    'assets/icons/cart_a.png',
                    height: 20,
                    color: AppTheme.primaryColor,
                  ),
                  icon: Image.asset(
                    'assets/icons/cart_in.png',
                    height: 20,
                    color: Color(getColorHexFromStr('#D6DBE6')),
                  ),
                ),
                BottomNavigationBarItem(
                  title: Text(
                    translator.currentLanguage == "en" ? "My account" : "حسابى",
                    style: _txtStyle,
                  ),
                  activeIcon: Image.asset(
                    'assets/icons/profile_a.png',
                    height: 20,
                    color: AppTheme.primaryColor,
                  ),
                  icon: Image.asset(
                    'assets/icons/profile_in.png',
                    height: 20,
                    color: Color(getColorHexFromStr('#D6DBE6')),
                  ),
                ),
              ],
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
          body: pages[_selectedIndex],
        ),
      ),
    );
  }
}
