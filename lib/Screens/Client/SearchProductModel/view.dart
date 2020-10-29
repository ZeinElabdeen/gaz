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
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Screens/Client/Cart/controller.dart';
import 'package:master/Screens/Client/ProductDetails/view.dart';
import 'package:master/Screens/Client/SearchProductModel/Widgets/AppBar.dart';
import 'Widgets/SearchCard.dart';
import 'model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'controller.dart';

class ClientSearchScreen extends StatefulWidget {
  @override
  _ClientSearchScreenState createState() => _ClientSearchScreenState();
}

class _ClientSearchScreenState extends State<ClientSearchScreen> {
  TextEditingController textEditingController = TextEditingController();
  ClientHomeSearchModel _model = ClientHomeSearchModel();
  SearchController _controller = SearchController();
  List<SearchItem> searchItem = [];
  bool _loading = false;
  bool noData = false;

  void _getData(String keyWord) async {
    setState(() {
      _loading = true;
    });
    CustomResponse response = await _controller.getData(keyWord: keyWord);
    if (response.success) {
      setState(() {
        _model = ClientHomeSearchModel.fromJson(response.response.data);
        searchItem = _model.data;
        _loading = false;
      });
    } else if (response.errType == 0) {
      setState(() {
        _loading = false;
      });
      showNetworkErrorDialog(context, () {
        Get.back();
      });
    }
  }

  @override
  void initState() {
    getLoginType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translator.currentLanguage == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          backgroundColor: AppTheme.backGroundColor,
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                elevation: 0,
                expandedHeight: 90.0,
                automaticallyImplyLeading: false,
                backgroundColor: AppTheme.primaryColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: SearchScreenAppBar(
                    onChanged: (val) {
                      setState(() {
                        searchItem = null;
                        _getData(textEditingController.text);
                      });
                    },
                    textEditingController: textEditingController,
                  ),
                ),
                snap: false,
                forceElevated: false,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  textEditingController.text.isEmpty
                      ? searchHereCard(context)
                      : _loading
                          //&& searchItem == null
                          ? gridViewShimmer(context)
                          : searchItem.isNotEmpty
                              ? GridView.builder(
                                  itemCount: searchItem.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      new SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 1,
                                          mainAxisSpacing: 1,
                                          childAspectRatio: .92),
                                  itemBuilder: (context, index) {
                                    return SearchProductCard(
                                      keyWord: searchItem[index],
                                      onTap: () {
                                        Get.to(
                                          ProductDetailsView(
                                            title: searchItem[index].name,
                                            id: searchItem[index].id,
                                            isAvailable: true,
                                          ),
                                        );
                                      },
                                      onAddToCartTapped: () {
                                        _openBottomSheet(
                                          context,
                                          searchItem[index].id,
                                          searchItem[index].name,
                                        );
                                      },
                                    );
                                  })
                              : noSearchDataFound(
                                  context,
                                )
                ]),
              )
            ],
          )),
    );
  }

  int quantity = 1;

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
                                  token == ""
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
