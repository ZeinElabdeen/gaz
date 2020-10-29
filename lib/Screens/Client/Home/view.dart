import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/NetworkDialog.dart';
import 'package:master/Helpers/CustomWidgets/Shimmer/Slider.dart';
import 'package:master/Helpers/CustomWidgets/Shimmer/cart.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/appBar.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Screens/Client/Category/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'card.dart';
import 'controller.dart';
import 'model.dart';

class ClientHomeView extends StatefulWidget {
  @override
  _ClientHomeViewState createState() => _ClientHomeViewState();
}

class _ClientHomeViewState extends State<ClientHomeView> {
  ClientHomeController _controller = ClientHomeController();
  ClientHomeModel _model = ClientHomeModel();

  void _getData() async {
    CustomResponse response = await _controller.getData();
    if (response.success) {
      setState(() {
        _model = ClientHomeModel.fromJson(response.response.data);
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
      appBar: homeAppBar(() {
        // token == null
        //     ? visitorDialog(context)
        //     : Get.to(
        //         ClientNotificationsView(),
        //       );
      }),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: TweenAnimationBuilder(
                duration: const Duration(seconds: 2),
                tween: Tween(begin: -MediaQuery.of(context).size.width, end: 0),
                builder: (BuildContext context, dynamic value, Widget child) {
                  return Transform.translate(
                    offset: Offset(value, 0),
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          child: _loading
                              ? homeSliderShimmer()
                              : Swiper(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Image(
                                      image: NetworkImage(
                                          _model.data.sliders[index].image),
                                      fit: BoxFit.fill,
                                    );
                                  },
                                  itemCount: _model.data.sliders.length,
                                  pagination: new SwiperPagination(),
                                  autoplay: true,
                                  outer: false,
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    translator.currentLanguage == "en"
                        ? "Categories"
                        : "الأقسام",
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        fontFamily: AppTheme.boldFont),
                  ),
                ],
              ),
              _loading
                  ? shimmerVerticalListView(context, 120)
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _model.data.categories.length,
                      primary: false,
                      itemBuilder: (context, int index) {
                        return clientHomeCard(
                            context: context,
                            txt: _model.data.categories[index].name,
                            backgroundImg:
                                _model.data.categories[index].backImage,
                            img: _model.data.categories[index].image,
                            onTap: () {
                              Get.to(
                                CategoryView(
                                  categoryId: _model.data.categories[index].id,
                                  title: _model.data.categories[index].name,
                                ),
                              );
                            });
                      },
                    ),
              SizedBox(
                height: 20,
              ),
            ]),
          )
        ],
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
