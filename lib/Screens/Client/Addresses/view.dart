import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/Btns.dart';
import 'package:master/Helpers/CustomWidgets/Dialogs.dart';
import 'package:master/Helpers/CustomWidgets/NetworkDialog.dart';
import 'package:master/Helpers/CustomWidgets/NoDataFound.dart';
import 'package:master/Helpers/CustomWidgets/Shimmer/cart.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/appBar.dart';
import 'package:master/Screens/Client/AddAddress/view.dart';
import 'package:master/Screens/Mutual/FullMap/view.dart';
import 'card.dart';
import 'controller.dart';
import 'model.dart';

class ClientAddressesView extends StatefulWidget {
  final String type;

  const ClientAddressesView({
    Key key,
    this.type,
  }) : super(key: key);
  @override
  _ClientAddressesViewState createState() => _ClientAddressesViewState();
}

class _ClientAddressesViewState extends State<ClientAddressesView> {
  AddressesController _controller = AddressesController();
  AddressesModel _model = AddressesModel();
  bool _loading = true;
  void _getData() async {
    CustomResponse response = await _controller.getAddresses();
    if (response.success) {
      setState(() {
        _model = AddressesModel.fromJson(response.response.data);
        _loading = false;
      });
    } else if (response.errType == 0) {
      showNetworkErrorDialog(context, () {
        Get.back();
        _getData();
      });
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          context: context,
          leading: true,
          title: translator.currentLanguage == "en" ? "Addresses" : "العناوين"),
      body: _loading
          ? shimmerVerticalListView(context, 120)
          : Directionality(
              textDirection: translator.currentLanguage == "en"
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              child: ListView(
                children: <Widget>[
                  _model.data.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 60, bottom: 60),
                          child: noDataFound(
                              context,
                              translator.currentLanguage == "en"
                                  ? "No addresses found"
                                  : "لا توجد عناوين"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _model.data.length,
                          primary: false,
                          itemBuilder: (context, int index) {
                            return addressCard(
                                context: context,
                                addressType: _model.data[index].type,
                                lat: double.parse(
                                    _model.data[index].lat.toString()),
                                lng: double.parse(
                                    _model.data[index].long.toString()),
                                flatNumber: _model.data[index].number,
                                streetNumber: _model.data[index].details,
                                onDeleteTapped: () {
                                  deleteDialog(
                                      context: context,
                                      onDeleteTapped: () {
                                        _deleteItem(_model.data[index].id);

                                        setState(() {
                                          _model.data.removeWhere((item) {
                                            return item.id ==
                                                _model.data[index].id;
                                          });
                                        });
                                      });
                                },
                                onCardTapped: () {
                                  if (widget.type == "take") {
                                    Get.back(
                                        result: {"data": _model.data[index]});
                                  } else {
                                    Get.to(
                                      FullMapPage(
                                        lat: double.parse(
                                            _model.data[index].lat.toString()),
                                        lng: double.parse(
                                            _model.data[index].long.toString()),
                                      ),
                                    );
                                  }
                                },
                                onEditTapped: () {
                                  Get.to(
                                    AddAddressView(
                                      isEdit: true,
                                      id: _model.data[index].id,
                                    ),
                                  ).then((value) {
                                    _getData();
                                  });
                                },
                                onMapTapped: () {
                                  Get.to(
                                    FullMapPage(
                                      lat: double.parse(
                                          _model.data[index].lat.toString()),
                                      lng: double.parse(
                                          _model.data[index].long.toString()),
                                    ),
                                  );
                                });
                          },
                        ),
                  btn(
                    context,
                    translator.currentLanguage == "en"
                        ? "Add address"
                        : "اضافة عنوان",
                    () {
                      Get.to(
                        AddAddressView(
                          isEdit: false,
                        ),
                      ).then((value) {
                        _getData();
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }

  void _deleteItem(int id) async {
    CustomResponse response = await _controller.deleteAddress(id: id);
    if (response.success) {
      Navigator.of(context).pop();
    }
  }
}
