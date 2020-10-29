import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/NetworkDialog.dart';
import 'package:master/Helpers/CustomWidgets/NoDataFound.dart';
import 'package:master/Helpers/CustomWidgets/Shimmer/cart.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/appBar.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Screens/Client/MyOrder/controler.dart';
import 'package:master/Screens/Client/MyOrder/tabs.dart';
import 'package:master/Screens/Client/Visitor/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CurrentModel.dart';
import 'FinishedModel.dart';
import 'card.dart';

class ClientOrdersView extends StatefulWidget {
  @override
  _ClientOrdersViewState createState() => _ClientOrdersViewState();
}

class _ClientOrdersViewState extends State<ClientOrdersView> {
  Widget _body() {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppTheme.thirdColor,
        child: TabBarView(controller: _controller, children: <Widget>[
          // ***********   current ****************
          token == null
              ? visitorScreen(context)
              : _currentLoading
                  ? shimmerVerticalListView(context, 90)
                  : _current.data.isEmpty
                      ? noDataFound(
                          context,
                          translator.currentLanguage == "en"
                              ? "No current orders found"
                              : "لا توجد طلبات حالية")
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _current.data.length,
                          primary: false,
                          itemBuilder: (context, int index) {
                            return providerOrderCard(
                                context: context,
                                onTap: () {
                                  // Get.to(
                                  //   ClientOrderDetailsView(
                                  //     type: "current",
                                  //     orderNumber: _current.data[index].id,
                                  //     status: 1,
                                  //   ),
                                  // );
                                },
                                orderNo: _current.data[index].id.toString(),
                                productsNo: _current.data[index].productCount
                                    .toString(),
                                isCurrent: true,
                                createdAt: _current.data[index].createdAt,
                                time: _current.data[index].date,
                                price: _current.data[index].total.toString());
                          },
                        ),
          // ***********   finished ****************
          token == null
              ? visitorScreen(context)
              : _finishedLoading
                  ? shimmerVerticalListView(context, 90)
                  : _finished.data.isEmpty
                      ? noDataFound(
                          context,
                          translator.currentLanguage == "en"
                              ? "No finished orders found"
                              : "لا توجد طلبات منتهية")
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _finished.data.length,
                          primary: false,
                          itemBuilder: (context, int index) {
                            return providerOrderCard(
                                context: context,
                                onTap: () {
                                  // Get.to(
                                  //   ClientOrderDetailsView(
                                  //     type: "finished",
                                  //     status: 2,
                                  //     orderNumber: _finished.data[index].id,
                                  //   ),
                                  // );
                                },
                                orderNo: _finished.data[index].id.toString(),
                                productsNo: _finished.data[index].productCount
                                    .toString(),
                                isCurrent: false,
                                createdAt: _finished.data[index].createdAt,
                                time: _finished.data[index].date,
                                price: _finished.data[index].total.toString());
                          },
                        ),

          //********************
        ]));
  }

  TabController _controller;

  @override
  void initState() {
    super.initState();
    getLoginType();
    _controller = new TabController(vsync: DrawerControllerState(), length: 2);
    _controller.index = 0;
    _getCurrentOrders();
    _controller.addListener(() {
      if (_controller.index == 0) {
        _getCurrentOrders();
      } else {
        _getFinishedOrders();
      }
    });
  }

  ClientOrdersController _controllerr = ClientOrdersController();
  ClientCurrentOrdersModel _current = ClientCurrentOrdersModel();
  bool _currentLoading = true;
  void _getCurrentOrders() async {
    CustomResponse response = await _controllerr.getCurrentOrders();
    if (response.success) {
      setState(() {
        _current = ClientCurrentOrdersModel.fromJson(response.response.data);
        _currentLoading = false;
      });
    } else if (response.errType == 0) {
      showNetworkErrorDialog(context, () {
        Get.back();
        _getCurrentOrders();
      });
    }
  }

  bool _finishedLoading = true;
  ClientFinishedOrdersModel _finished = ClientFinishedOrdersModel();
  void _getFinishedOrders() async {
    CustomResponse response = await _controllerr.getFinishedOrders();
    if (response.success) {
      setState(() {
        _finished = ClientFinishedOrdersModel.fromJson(response.response.data);
        _finishedLoading = false;
      });
    } else if (response.errType == 0) {
      showNetworkErrorDialog(context, () {
        Get.back();
        _getCurrentOrders();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: appBar(
            context: context,
            leading: false,
            title: translator.currentLanguage == "en" ? "My orders" : "طلباتى"),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              clientOrdersTabs(context, _controller),
              Expanded(
                child: _body(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String token;

  getLoginType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
  }
}
