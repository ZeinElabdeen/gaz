import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/Btns.dart';
import 'package:master/Helpers/CustomWidgets/Dialogs.dart';
import 'package:master/Helpers/CustomWidgets/NetworkDialog.dart';
import 'package:master/Helpers/CustomWidgets/NoDataFound.dart';
import 'package:master/Helpers/CustomWidgets/Shimmer/cart.dart';
import 'package:master/Helpers/CustomWidgets/counter.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/appBar.dart';
import 'package:master/Screens/Client/PurchaseFollowing/view.dart';
import 'package:master/Screens/Client/Visitor/view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'card.dart';
import 'controller.dart';
import 'model.dart';

class ClientCartView extends StatefulWidget {
  @override
  _ClientCartViewState createState() => _ClientCartViewState();
}

class _ClientCartViewState extends State<ClientCartView> {
  CartController _controller = CartController();
  CartModel _model = CartModel();

  void _getData() async {
    CustomResponse response = await _controller.getCartData();
    if (response.success) {
      setState(() {
        _model = CartModel.fromJson(response.response.data);

        _loading = false;
      });
    } else if (response.errType == 0) {
      showNetworkErrorDialog(context, () {
        Get.back();
        _getData();
      });
    }
  }

  void _deleteItem(int productId) async {
    CustomResponse response =
        await _controller.deleteFromCart(productId: productId);
    if (response.success) {
      Navigator.of(context).pop();
    } else if (response.errType == 0) {
      showNetworkErrorDialog(context, () {
        Get.back();
        _getData();
      });
    }
  }

  void getDataAfterUpdate() async {
    CustomResponse response = await _controller.getCartData();
    setState(() {
      _model = CartModel.fromJson(response.response.data);
    });
  }

  void _editQuantity(int productId, int quantity) async {
    int currentIndex = _model.data.products.indexWhere((element) {
      return element.id == productId;
    });
    setState(() {
      _model.data.products[currentIndex].loading = true;
    });
    CustomResponse response =
        await _controller.addToCart(productId: productId, quantity: quantity);
    if (response.success) {
      setState(() {
        _model.data.products[currentIndex].loading = false;
      });
      getDataAfterUpdate();
      Toast.show(
          translator.currentLanguage == "en"
              ? "Quantity updated successfully"
              : "تم تعديل الكمية بنجاح",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER);
    } else if (response.errType == 0) {
      showNetworkErrorDialog(context, () {
        Get.back();
        _getData();
      });
    }
  }

  bool _loading = true;
  @override
  void initState() {
    getLoginType();
    _getData();
    super.initState();
  }

  int quantity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Directionality(
      textDirection: translator.currentLanguage == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          appBar: appBar(
              context: context,
              title: translator.currentLanguage == "en" ? "Cart" : "السلة",
              leading: false),
          body: token == null
              ? visitorScreen(context)
              : _loading
                  ? shimmerVerticalListView(context, 80)
                  : _model.data.products.isEmpty
                      ? noDataFound(
                          context,
                          translator.currentLanguage == "en"
                              ? "No products in cart"
                              : "السلة فارغة")
                      : ListView(
                          shrinkWrap: true,
                          primary: true,
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    //height: MediaQuery.of(context).size.height*.5,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: _model.data.products.length,
                                      primary: false,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return cartItemCard(
                                            context: context,
                                            img: _model
                                                .data.products[index].image,
                                            productName: _model
                                                .data.products[index].name,
                                            price: _model
                                                .data.products[index].price,
                                            onDeleteTapped: () {
                                              print(
                                                  ">>>>>>>>>>>>>>>>>> delete presses ");
                                              deleteDialog(
                                                  context: context,
                                                  onDeleteTapped: () {
                                                    _deleteItem(_model.data
                                                        .products[index].id);
                                                    setState(() {
                                                      _model.data.products
                                                          .removeWhere((item) {
                                                        return item.id ==
                                                            _model
                                                                .data
                                                                .products[index]
                                                                .id;
                                                      });
                                                    });
                                                  });
                                            },
                                            counter: Counterwidget(
                                              initialValue: int.parse(_model
                                                  .data
                                                  .products[index]
                                                  .quantity),
                                              minValue: 1,
                                              width: 130,
                                              maxValue: 111,
                                              decimalPlaces: 0,
                                              onChanged: (value) {
                                                setState(() {
                                                  _model.data.products[index]
                                                          .quantity =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            editLoading: _model
                                                .data.products[index].loading,
                                            onEditTapped: () {
                                              _editQuantity(
                                                  _model
                                                      .data.products[index].id,
                                                  int.parse(_model
                                                      .data
                                                      .products[index]
                                                      .quantity));
                                            });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  totalText(total: _model.data.total),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 30),
                                    child: btn(
                                      context,
                                      translator.currentLanguage == "en"
                                          ? "purchasing review"
                                          : "متابعه الشراء",
                                      () {
                                        Get.to(PurchaseFollowingView(
                                          orderNumber: "12",
                                          type: "a",
                                        ));
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
    ));
  }

  String token;

  getLoginType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
  }
}
