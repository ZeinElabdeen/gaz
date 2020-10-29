import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/AwsomeDialog.dart';
import 'package:master/Helpers/CustomWidgets/Btns.dart';
import 'package:master/Helpers/CustomWidgets/Text.dart';
import 'package:master/Helpers/CustomWidgets/counter.dart';
import 'package:master/Helpers/Loaders.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/appBar.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Helpers/customWidget/NetworkDialog.dart';
import 'package:master/Screens/Client/Cart/controller.dart';
import 'package:master/Screens/Client/ProductDetails/controller.dart';
import 'package:master/Screens/Client/ProductDetails/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ProductDetailsView extends StatefulWidget {
  final bool isAvailable;
  final int id;
  final String title;
  const ProductDetailsView({Key key, this.isAvailable, this.id, this.title})
      : super(key: key);
  @override
  _ProductDetailsViewState createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  ProductDetailsController _controller = ProductDetailsController();
  ProductDetailsModel _model = ProductDetailsModel();
  void _getData() async {
    CustomResponse response = await _controller.getData(id: widget.id);
    if (response.success) {
      setState(() {
        _model = ProductDetailsModel.fromJson(response.response.data);
        price = int.parse(_model.data.price);
        total = price * quantity;
        _loading = false;
      });
    } else if (response.errType == 0) {
      showNetworkErrorDialog(context, () {
        Get.back();
        _getData();
      });
    }
  }

  int price;
  int total;
  bool _loading = true;
  @override
  void initState() {
    getLoginType();
    _getData();
    super.initState();
  }

  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, leading: true, title: widget.title),
      body: Directionality(
        textDirection: translator.currentLanguage == "en"
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: _loading
            ? loader()
            : ListView(
                shrinkWrap: false,
                primary: true,
                children: <Widget>[
                  Image.network(
                    _model.data.image,
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                  titleText(_model.data.name),
                  priceText(total.toString()),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Counterwidget(
                      initialValue: quantity,
                      minValue: 1,
                      color: Colors.red,
                      maxValue: 111,
                      decimalPlaces: 0,
                      onChanged: (value) {
                        setState(() {
                          quantity = value;
                          total = quantity * price;
                        });
                      },
                    ),
                  ),
                  titleText(translator.currentLanguage == "en"
                      ? "Description"
                      : "الوصف"),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Text(
                      _model.data.desc,
                      style: TextStyle(
                          color: AppTheme.secondaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  _btnLoading
                      ? authLoader()
                      : Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 20),
                          child: widget.isAvailable
                              ? btn(
                                  context,
                                  translator.currentLanguage == "en"
                                      ? "Add to cart"
                                      : "اضافة الى السلة",
                                  () {
                                    token == null
                                        ? visitorDialog(context)
                                        : _addToCart(widget.id);
                                  },
                                )
                              : Container(),
                        ),
                ],
              ),
      ),
    );
  }

  CartController _cartController = CartController();
  bool _btnLoading = false;
  void _addToCart(int productId) async {
    setState(() {
      _btnLoading = true;
    });
    CustomResponse response = await _cartController.addToCart(
        productId: productId, quantity: quantity);
    if (response.success) {
      Toast.show(
          translator.currentLanguage == "en"
              ? "Product added to cart successfully"
              : "تم اضافة المنتج الى السلة بنجاح",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER);
      setState(() {
        _btnLoading = false;
      });
      // Get.to(
      //   ClientBottomNavigationView(
      //     pageIndex: 2,
      //   ),
      // );
    }
  }

  String token;

  getLoginType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
  }
}
