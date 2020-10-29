import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/Btns.dart';
import 'package:master/Helpers/CustomWidgets/ChooseTypeCard.dart';
import 'package:master/Helpers/CustomWidgets/NetworkDialog.dart';
import 'package:master/Helpers/CustomWidgets/Text.dart';
import 'package:master/Helpers/Loaders.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/appBar.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Screens/Client/Addresses/model.dart';
import 'package:master/Screens/Client/Addresses/view.dart';
import 'package:master/Screens/Client/PurchaseFollowing/model.dart';
import 'package:master/Screens/Mutual/SuccessfullyDone/purchase.dart';
import 'package:toast/toast.dart';
import 'Widgets/AddressCard.dart';
import 'Widgets/PaymentSummary.dart';
import 'Widgets/item.dart';
import 'package:intl/intl.dart' as formDateTime;

import 'controller.dart';

class PurchaseFollowingView extends StatefulWidget {
  final String orderNumber, type;
  PurchaseFollowingView({this.orderNumber, this.type});
  @override
  _PurchaseFollowingViewState createState() => _PurchaseFollowingViewState();
}

class _PurchaseFollowingViewState extends State<PurchaseFollowingView> {
  PurchaseFollowingController _controller = PurchaseFollowingController();
  PurchaseFollowingModel _model = PurchaseFollowingModel();
  bool _loading = true;
  void _getData() async {
    CustomResponse response = await _controller.getData();
    setState(() {
      _model = PurchaseFollowingModel.fromJson(response.response.data);
      _loading = false;
    });
  }

  int addressId;
  String formedTime;
  void _getFormDatedTime() {
    formedTime =
        "${formDateTime.DateFormat.MMMMEEEEd(translator.currentLanguage == "en" ? "en_US" : "ar_EG").format(time)}  ${formDateTime.DateFormat.jm(translator.currentLanguage == "en" ? "en_US" : "ar_EG").format(time)}  ";
  }

  bool _submitLoading = false;
  void _submit() async {
    if (addressId == null) {
      Toast.show(
          translator.currentLanguage == "en"
              ? "Please select address"
              : "من فضلك اختر العنوان",
          context,
          gravity: Toast.CENTER);
    } else if (time == null) {
      Toast.show(
          translator.currentLanguage == "en"
              ? "Please select date and time"
              : "من فضلك اختر الوقت والتاريخ",
          context,
          gravity: Toast.CENTER);
    } else {
      setState(() {
        _submitLoading = true;
      });
      CustomResponse response = await _controller.confirmOrder(
          addressId: addressId, date: datePicked, time: timePicked);
      if (response.success) {
        setState(() {
          _submitLoading = false;
        });
        Get.to(
          SuccessfullyDonePurchasesView(
            orderPrice: _model.data.total.toString(),
          ),
        );
      } else if (response.errType == 0) {
        showNetworkErrorDialog(context, () {
          Get.back();
          _getData();
        });
      }
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  ClientAddressData _clientAddressData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          context: context,
          leading: true,
          title: translator.currentLanguage == "en"
              ? "Follow purchasing"
              : "متابعة الشراء"),
      body: _loading
          ? loader()
          : Directionality(
              textDirection: translator.currentLanguage == "en"
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              child: ListView(
                shrinkWrap: false,
                primary: true,
                children: <Widget>[
                  _clientAddressData != null
                      ? Container()
                      : chooseTypeCard(
                          context: context,
                          txt: translator.currentLanguage == "en"
                              ? "Choose address"
                              : "اختر العنوان",
                          onTap: () {
                            Get.to(
                              ClientAddressesView(
                                type: "take",
                              ),
                            ).then((result) {
                              setState(() {
                                _clientAddressData = result['data'];
                                addressId = _clientAddressData.id;
                              });
                            });
                          }),
                  _clientAddressData == null
                      ? Container()
                      : purchaseFollowingAddressCard(
                          context: context,
                          addressType: _clientAddressData.type,
                          lng: double.parse(_clientAddressData.long.toString()),
                          lat: double.parse(_clientAddressData.lat.toString()),
                          flatNumber: _clientAddressData.number,
                          streetNumber: _clientAddressData.details,
                          onCardTapped: () {
                            Get.to(
                              ClientAddressesView(
                                type: "take",
                              ),
                            ).then((result) {
                              setState(() {
                                _clientAddressData = result['data'];
                                addressId = _clientAddressData.id;
                              });
                            });
                          },
                          onMapTapped: () {},
                          isEdit: _clientAddressData == null ? false : true),
                  productDetailsItem(
                    img: "assets/icons/time_order.png",
                    context: context,
                    title: translator.currentLanguage == "en"
                        ? "Delivery time"
                        : "وقت التسليم",
                    onTap: () {
                      _openTimePickerBottomSheet(context).then((value) {
                        setState(() {
                          _getFormDatedTime();
                        });
                      });
                    },
                    description: formedTime != null
                        ? formedTime
                        : translator.currentLanguage == "en"
                            ? "Choose delivery time"
                            : "اختر وقت التسليم",
                  ),
                  paymentSummaryCard(
                      productsPrice: _model.data.subTotal,
                      shippingPrice: _model.data.delivery.toString(),
                      additionalTax: _model.data.tax,
                      total: _model.data.total.toString()),
                  _submitLoading
                      ? authLoader()
                      : btn(
                          context,
                          translator.currentLanguage == "en"
                              ? "Confirm purchasing"
                              : "اتمام الشراء",
                          () {
                            _submit();
                          },
                        ),
                ],
              )),
    );
  }

  Future _openTimePickerBottomSheet(
    BuildContext context,
  ) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        builder: (BuildContext context) {
          return Directionality(
            textDirection: translator.currentLanguage == 'en'
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Container(
                height: 360,
                decoration: BoxDecoration(
                  color: AppTheme.backGroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: StatefulBuilder(builder: (context, StateSetter rebuild) {
                  return Column(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          bottomSheetTitle(translator.currentLanguage == "en"
                              ? "Choose time"
                              : "اختر الوقت"),
                          Container(
                            height: 200,
                            child: CupertinoDatePicker(
                              onDateTimeChanged: (date) {
                                rebuild(() {
                                  datePicked =
                                      "${date.year.toString() + date.month.toString() + date.day.toString()}";
                                  timePicked =
                                      "${date.hour.toString() + date.minute.toString()}";

                                  time = date;
                                });

                                print(datePicked +
                                    "<<<<<<<<<<<<<<<<<<<< datePicked");
                                print(timePicked + "<<<<<<<<<<<<<<<<<<<< time");
                              },
                              initialDateTime: DateTime.now(),
                              use24hFormat: false,
                              minimumYear: 1,
                              maximumYear: 3,
                              minuteInterval: 1,
                              mode: CupertinoDatePickerMode.dateAndTime,
                            ),
                          ),
                          dialogBtn(
                              context,
                              translator.currentLanguage == "en"
                                  ? "Confirm"
                                  : "تأكيد", () {
                            Get.back();
                          }),
                        ],
                      ),
                    ],
                  );
                })),
          );
        });
  }

  int pickedTime;
  String datePicked;
  String timePicked;
  DateTime time;
}
