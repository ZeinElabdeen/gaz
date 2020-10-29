import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/CustomWidgets/Btns.dart';
import 'package:master/Helpers/CustomWidgets/ChooseTypeCard.dart';
import 'package:master/Helpers/CustomWidgets/DropDown.dart';
import 'package:master/Helpers/CustomWidgets/NetworkDialog.dart';
import 'package:master/Helpers/Loaders.dart';
import 'package:master/Helpers/ServerGate.dart';
import 'package:master/Helpers/appBar.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Helpers/text_filed.dart';
import 'package:master/Screens/Client/AddAddress/controller.dart';
import 'package:toast/toast.dart';

import 'SingleAddressModel.dart';
import 'card.dart';

class AddAddressView extends StatefulWidget {
  final bool isEdit;
  final int id;
  const AddAddressView({Key key, this.isEdit, this.id}) : super(key: key);
  @override
  _AddAddressViewState createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  ClientAddressesController _controllerr = ClientAddressesController();

  bool _loading = false;
  void _submit() {
    if (!_formKey.currentState.validate())
      return;
    else if (typeId == null) {
      Toast.show(
          translator.currentLanguage == "en"
              ? "Address type is required"
              : " نوع العنوان مطلوبء",
          context,
          gravity: Toast.CENTER);
    } else {
      _formKey.currentState.save();
      setState(() {
        _loading = true;
      });
      _controllerr
          .addNewAddress(
              lat: latitude,
              long: longitude,
              type: typeId,
              flatNumber: flatNumber,
              nearPlace: nearPlace,
              details: instructions)
          .then((response) {
        if (response.success) {
          setState(() {
            _loading = false;
          });
          Get.back();
        } else if (response.errType == 0) {
          showNetworkErrorDialog(context, () {
            Get.back();
          });
        }
      });
    }
  }

  bool _editLoading = false;
  void _editAddressSubmitted() {
    if (!_formKey.currentState.validate())
      return;
    else if (typeId == null) {
      Toast.show(
          translator.currentLanguage == "en"
              ? "Address type is required"
              : " نوع العنوان مطلوب",
          context,
          gravity: Toast.CENTER);
    } else {
      _formKey.currentState.save();
      setState(() {
        _editLoading = true;
      });
      _controllerr
          .editAddress(
              addressId: widget.id,
              lat: latitude,
              long: longitude,
              type: typeId,
              flatNumber: _flatNumberController.text,
              nearPlace: _nearPlaceController.text,
              details: _instructionsController.text)
          .then((response) {
        print(
            response.response.data.toString() + " <<<<<<<<<<<<<<<<<<<<<<<,  ");
        if (response.success) {
          setState(() {
            _editLoading = false;
          });
          Get.back();
        } else if (response.errType == 0) {
          showNetworkErrorDialog(context, () {
            Get.back();
          });
        }
      });
    }
  }

  String instructions, flatNumber, nearPlace;
  //***********************************
  TextEditingController _instructionsController = TextEditingController();
  TextEditingController _flatNumberController = TextEditingController();
  TextEditingController _nearPlaceController = TextEditingController();

  SingleAddressDetailsModel _singleAddressDetailsModel =
      SingleAddressDetailsModel();
  bool _getAddressDetailsLoading = true;
  void _getAddressDetails() async {
    CustomResponse response =
        await _controllerr.getSingleAddress(addressId: widget.id);
    print(response.response.toString() + "  <<<<<<<<<<<<<<<<<<<< ");
    print(
        response.statusCode.toString() + "  <<<<<<<<<<<<<<<<<<<< statusCode ");
    if (response.success) {
      setState(() {
        _singleAddressDetailsModel =
            SingleAddressDetailsModel.fromJson(response.response.data);
        _instructionsController.text = _singleAddressDetailsModel.data.details;
        _flatNumberController.text = _singleAddressDetailsModel.data.number;
        _nearPlaceController.text = _singleAddressDetailsModel.data.nearPlace;
        typeName = _singleAddressDetailsModel.data.type;
        typeId = _singleAddressDetailsModel.data.type;
        latitude = double.parse(_singleAddressDetailsModel.data.lat);
        longitude = double.parse(_singleAddressDetailsModel.data.long);
        currentLocation = _singleAddressDetailsModel.data.details;
        setLocation();
        _getAddressDetailsLoading = false;
      });
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    widget.isEdit ? _getAddressDetails() : print("object");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          context: context,
          leading: true,
          title: translator.currentLanguage == "en"
              ? "Add address"
              : "اضافه  عنوان"),
      backgroundColor: AppTheme.backGroundColor,
      body: widget.isEdit && _getAddressDetailsLoading
          ? loader()
          : Form(
              key: _formKey,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        latitude != null
                            ? Container(
                                height: 20,
                              )
                            : chooseTypeCard(
                                context: context,
                                onTap: () async {
                                  showLocationPicker(context,
                                          "AIzaSyD8of-XmJr7P140k3J1Bs0ixcXh2JvxFN0",
                                          automaticallyAnimateToCurrentLocation:
                                              true,
                                          appBarColor: AppTheme.appBarColor,
                                          myLocationButtonEnabled: true,
                                          layersButtonEnabled: true,
                                          requiredGPS: true)
                                      .then((result) {
                                    setState(() {
                                      print(result.latLng.latitude.toString() +
                                          ">>>>>>>>>>>>> lat");
                                      print(result.latLng.longitude.toString() +
                                          ">>>>>>>>>>>>> long");
                                      latitude = result.latLng.latitude;
                                      longitude = result.latLng.longitude;
                                      currentLocation = result.address;
                                      setLocation();
                                    });
                                  });
                                },
                                txt: translator.currentLanguage == "en"
                                    ? "Location on map"
                                    : "العنوان على الخريطة",
                              ),
                        latitude != null ? _googleMap() : Container(),

                        addressDropDownContainer(
                            context: context,
                            onTap: () {
                              _openTypeBottomSheet(context);
                            },
                            txt: typeName != null
                                ? typeName
                                : translator.currentLanguage == "en"
                                    ? "Address type"
                                    : "نوع العنوان"),
                        addressesTextFormField(
                            context: context,
                            obscureText: false,
                            onSaved: (val) {
                              setState(() {
                                instructions = val;
                              });
                            },
                            validator: (String val) {
                              if (val.isEmpty)
                                return translator.currentLanguage == "en"
                                    ? "Instructions is required"
                                    : "تعليمات الموصل مطلوبة";
                              else
                                return null;
                            },
                            textInputType: TextInputType.text,
                            controller: _instructionsController,
                            labelText: translator.currentLanguage == "en"
                                ? "Any instructions to driver ?)"
                                : "أي تعليمات اخري للموصل ؟",
                            maxLines: 4),
                        SizedBox(
                          height: AppTheme.sizedBoxHeight,
                        ),
                        addressesTextFormField(
                            context: context,
                            obscureText: false,
                            onSaved: (val) {
                              setState(() {
                                flatNumber = val;
                              });
                            },
                            validator: (String val) {
                              if (val.isEmpty)
                                return translator.currentLanguage == "en"
                                    ? "Flat number is required"
                                    : "رقم الشقه مطلوب";
                              else
                                return null;
                            },
                            textInputType: TextInputType.text,
                            controller: _flatNumberController,
                            labelText: translator.currentLanguage == "en"
                                ? "Flat number"
                                : "رقم الشقه",
                            maxLines: 1),
//                SizedBox(
//                  height: AppTheme.sizedBoxHeight,
//                ),
//                addressesTextFormField(
//                    context: context,
//                    obscureText: false,
//                    onSaved: (val) {},
//                    validator: (val) {},
//                    textInputType: TextInputType.phone,
//                    controller: null,
//                    labelText: translator.currentLanguage == "en"
//                        ? "Mobile number"
//                        : "رقم الجوال",
//                    maxLines: 1),
                        SizedBox(
                          height: AppTheme.sizedBoxHeight,
                        ),
                        addressesTextFormField(
                            context: context,
                            obscureText: false,
                            onSaved: (val) {
                              setState(() {
                                nearPlace = val;
                              });
                            },
                            validator: null,
                            textInputType: TextInputType.text,
                            controller: _nearPlaceController,
                            labelText: translator.currentLanguage == "en"
                                ? "Nearest place (Optional)"
                                : "أقرب معلم (اختياري)",
                            maxLines: 1),
                        SizedBox(
                          height: AppTheme.sizedBoxHeight,
                        ),
                        (() {
                          if (widget.isEdit) {
                            return _editLoading
                                ? authLoader()
                                : btn(
                                    context,
                                    translator.currentLanguage == "en"
                                        ? "Edit the address"
                                        : "تعديل العنوان", () {
                                    _editAddressSubmitted();
                                  });
                          } else {
                            return _loading
                                ? authLoader()
                                : btn(
                                    context,
                                    translator.currentLanguage == "en"
                                        ? "Add the address"
                                        : "اضافة العنوان", () {
                                    _submit();
                                  });
                          }
                        }()),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )),
            ),
    );
  }

  double sizedBoxHeight = 15.0;
  double latitude, longitude;
  // TextEditingController locations = TextEditingController();

  CameraPosition _kGooglePlex;
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];

  void setLocation() async {
    _kGooglePlex = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14.4746,
    );

    markers.add(Marker(
      markerId: MarkerId(""),
      draggable: true,
      position: LatLng(
        latitude,
        longitude,
      ),
    ));
  }

  Widget _googleMap() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * .9,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12))),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12), topLeft: Radius.circular(12)),
              child: GoogleMap(
                onTap: (k) {},
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                mapType: MapType.normal,
                markers: Set.from(markers),
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ),
          addressText(
              context: context,
              onEditTapped: () async {
                showLocationPicker(
                        context, "AIzaSyD8of-XmJr7P140k3J1Bs0ixcXh2JvxFN0",
                        automaticallyAnimateToCurrentLocation: true,
                        appBarColor: AppTheme.appBarColor,
                        myLocationButtonEnabled: true,
                        layersButtonEnabled: true,
                        requiredGPS: true)
                    .then((result) {
                  setState(() {
                    latitude = result.latLng.latitude;
                    longitude = result.latLng.longitude;
                    currentLocation = result.address;
                    setLocation();
                  });
                });
              },
              address: currentLocation),
        ],
      ),
    );
  }

  void _openTypeBottomSheet(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * .6,
            child: CupertinoActionSheet(
              cancelButton: CupertinoButton(
                child: Text(
                  translator.currentLanguage == "en"
                      ? "Address type"
                      : "نوع العنوان",
                  style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: typeList
                  .map(
                    (item) => CupertinoButton(
                      child: Center(
                        child: Text(
                          item["name"],
                          style: TextStyle(
                              fontFamily: AppTheme.fontName,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          typeName = item["name"];
                          typeId = item["id"];
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        });
  }

  List<Map<String, dynamic>> typeList = [
    {
      "id": "المنزل",
      "name": translator.currentLanguage == "en" ? "Home" : "المنزل",
    },
    {
      "id": "العمل",
      "name": translator.currentLanguage == "en" ? "Work" : "العمل",
    },
  ];
  String typeName;
  var typeId;

  String currentLocation;
}
