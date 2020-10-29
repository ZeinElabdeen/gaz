//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:gas/Helpers/CustomWidgets/Btns.dart';
//import 'package:localize_and_translate/localize_and_translate.dart';
//
//
//Widget datePicker() {
//  return Container(
//    color: Colors.black.withOpacity(.5),
//    child: Column(
//      mainAxisSize: MainAxisSize.max,
//      mainAxisAlignment: MainAxisAlignment.end,
//      children: <Widget>[
//        Card(
//          shape: RoundedRectangleBorder(
//              borderRadius: new BorderRadius.only(
//                  topLeft: const Radius.circular(35),
//                  topRight: const Radius.circular(35))),
//          elevation: 20,
//          child: Container(
//            height: 350,
//            width: MediaQuery.of(context).size.width,
//            // color: Colors.white,
//            decoration: new BoxDecoration(
//              // color: Colors.red,
//                borderRadius: new BorderRadius.only(
//                    topLeft: const Radius.circular(35),
//                    topRight: const Radius.circular(35))),
//            child: Stack(
//              children: <Widget>[
//                Container(
//                  height: 350.0,
//                  child: CupertinoDatePicker(
//                    onDateTimeChanged: (date) {
//                      setState(() {
//                        datePicked = date.toString();
//                      });
//                      print(datePicked);
//                    },
//                    initialDateTime: DateTime.now(),
//                    use24hFormat: true,
////                       minimumYear: 1,
////                       maximumYear: 10,
////                       minuteInterval: 1,
//                    // mode: CupertinoDatePickerMode.dateAndTime,
//                  ),
//                ),
//                Positioned(
//                  bottom: 50,
//                  right: 20,
//                  left: 20,
//                  child: btn(context,
//                    translator.currentLanguage == 'ar'
//                        ? 'تأكيد'
//                        : 'Confirm',
//                        () {
//                      setState(() {
//                        show = false;
//                      });
//                    },
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
//      ],
//    ),
//  );
//}