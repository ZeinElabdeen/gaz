import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/AwsomeDialog.dart';
import 'package:master/Helpers/CustomWidgets/Btns.dart';
import 'package:master/Helpers/CustomWidgets/NetworkDialog.dart';
import 'package:master/Helpers/CustomWidgets/NoDataFound.dart';
import 'package:master/Helpers/CustomWidgets/Shimmer/gridView.dart';
import 'package:master/Helpers/CustomWidgets/Text.dart';
import 'package:master/Helpers/CustomWidgets/counter.dart';
import 'package:master/Helpers/Loaders.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/appBar.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Screens/Client/Cart/controller.dart';
import 'package:master/Screens/Client/Category/card.dart';
import 'package:master/Screens/Client/Category/model.dart';
import 'package:master/Screens/Client/ProductDetails/view.dart';
import 'package:master/Screens/Client/SearchProductModel/view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'controller.dart';

class CategoryView extends StatefulWidget {
  final int categoryId;
  final String title;
  const CategoryView({Key key, this.categoryId, this.title}) : super(key: key);
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  int quantity = 1;
  int tabIndex;
  ClientCategoryProductsController _controller =
      ClientCategoryProductsController();
  ClientCategoryProductsModel _model = ClientCategoryProductsModel();
  void _getData() async {
    CustomResponse response =
        await _controller.getData(categoryId: widget.categoryId);
    if (response.success) {
      setState(() {
        _model = ClientCategoryProductsModel.fromJson(response.response.data);
        _loading = false;
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backGroundColor,
      appBar: appBarWithAction(
        context: context,
        leading: true,
        title: widget.title,
        actionIcon: Container(
          alignment: Alignment.center,
          child: IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Get.to(
                ClientSearchScreen(),
              );
            },
          ),
        ),
      ),
      body: _loading
          ? gridViewShimmer(context)
          : _model.data.isEmpty
              ? noDataFound(
                  context,
                  translator.currentLanguage == "en"
                      ? "No data found"
                      : "لا توجد منتجات")
              : GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: _model.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 1,
                    childAspectRatio: .85,
                    crossAxisCount: 2,
                    mainAxisSpacing: 1,
                  ),
                  itemBuilder: (context, index) {
                    return categoryCard(
                        context: context,
                        img: _model.data[index].image,
                        onAddToCartTapped: () {
                          _openBottomSheet(context, _model.data[index].id,
                              _model.data[index].name);
                        },
                        onTap: () {
                          Get.to(
                            ProductDetailsView(
                              isAvailable: true,
                              id: _model.data[index].id,
                              title: _model.data[index].name,
                            ),
                          );
                        },
                        price: _model.data[index].price,
                        productName: _model.data[index].name);
                  },
                ),
    );
  }

  Future _openBottomSheet(BuildContext context, int id, String name) {
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
                height: 200,
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
                          bottomSheetTitle(name),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Counterwidget(
                              initialValue: quantity,
                              minValue: 1,
                              color: Colors.red,
                              maxValue: 111,
                              decimalPlaces: 0,
                              onChanged: (value) {
                                rebuild(() {
                                  quantity = value;
                                });
                              },
                            ),
                          ),
                          _btnLoading
                              ? authLoader()
                              : dialogBtn(
                                  context,
                                  translator.currentLanguage == "en"
                                      ? "Add to cart"
                                      : "أضف الى السلة", () {
                                  token == null
                                      ? visitorDialog(context)
                                      : _addToCart(id, rebuild);
                                }),
                        ],
                      ),
                    ],
                  );
                })),
          );
        });
  }

  CartController _cartController = CartController();
  bool _btnLoading = false;
  void _addToCart(int productId, StateSetter rebuild) async {
    rebuild(() {
      _btnLoading = true;
    });
    CustomResponse response = await _cartController.addToCart(
        productId: productId, quantity: quantity);
    if (response.success) {
      Get.back();
      rebuild(() {
        _btnLoading = false;
      });
      Toast.show(
          translator.currentLanguage == "en"
              ? "Product added to cart successfully"
              : "تم اضافة المنتج الى السلة بنجاح",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER);
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
