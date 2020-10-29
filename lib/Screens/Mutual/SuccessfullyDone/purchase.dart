import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Screens/Client/Clien.dart';

class SuccessfullyDonePurchasesView extends StatefulWidget {
  final String orderPrice;

  const SuccessfullyDonePurchasesView({Key key, this.orderPrice})
      : super(key: key);
  @override
  _SuccessfullyDonePurchasesViewState createState() =>
      _SuccessfullyDonePurchasesViewState();
}

class _SuccessfullyDonePurchasesViewState
    extends State<SuccessfullyDonePurchasesView> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translator.currentLanguage == "en"
          ? TextDirection.ltr
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppTheme.backGroundColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: AppTheme.primaryColor),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 20),
                  child: Text(
                    translator.currentLanguage == "en"
                        ? "Thanks for using our app"
                        : "شكرا لاستخدامك تطبيق الغازات الفائقة",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    "assets/icons/thanks.png",
                    width: MediaQuery.of(context).size.width * .7,
                    height: MediaQuery.of(context).size.width * .7,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 60),
                  child: Text(
                    translator.currentLanguage == "en"
                        ? "Purchasing finished successfully"
                        : "تم انهاء الشراء بنجاح",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
//                Text(
//                  "${translator.currentLanguage == "en" ? "Order number : " : "رقم الطلب : "} 3232",
//                  style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 20,
//                    fontWeight: FontWeight.w900,
//                  ),
//                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50, top: 20),
                  child: Text(
                    "${translator.currentLanguage == "en" ? "Order value : " : "قيمة الطلب : "} ${widget.orderPrice}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Get.to(
                      Clin(),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        translator.currentLanguage == "en"
                            ? "Home page"
                            : "الصفحة الرئيسية",
                        style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
