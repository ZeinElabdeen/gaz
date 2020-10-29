import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class FullMapPage extends StatefulWidget {
  final double lat, lng;
  const FullMapPage({Key key, this.lat, this.lng}) : super(key: key);
  @override
  _FullMapPageState createState() => _FullMapPageState();
}

class _FullMapPageState extends State<FullMapPage> {
  GoogleMapController myController;
  double currentLat;
  double currentLong;
  String searchAddress = 'Search with Locations';
  Marker marker = Marker(markerId: MarkerId("1"));
  var location = Location();
  List<Marker> markers = [];

  void initState() {
    // _getFilter(model.loadFilterWashersResponse);

    setState(() {
      currentLat = widget.lat;
      currentLong = widget.lng;
      print( widget.lat.toString() + 'my laaaaaaaaaaaaaaaaaat');
      print( widget.lng.toString() + 'my looooooooooooooooong');

      markers.add(Marker(
        markerId: MarkerId(""),
        draggable: true,
        position: LatLng(
          widget.lat,
          widget.lng,
        ),
        onTap: () {
          _changeMapType();
        },
        //infoWindow: InfoWindow(title: widget.name ?? ""),
      ));
    });

    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  MapType _defaultMapType = MapType.normal;

  _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.satellite
          ? MapType.terrain
          : MapType.hybrid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
          textDirection: TextDirection.ltr,
          child: currentLat == null && currentLong == null
              ? Center(
              child: CupertinoActivityIndicator(
                animating: true,
                radius: 15,
              ))
              : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    mapType: _defaultMapType,
                    myLocationEnabled: true,
                    onMapCreated: _onMapCreated,zoomGesturesEnabled: true,
                    markers: Set.from(markers),scrollGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(widget.lat, widget.lng), zoom: 14),
                  ),
                ],
              ))),
    );
  }
}
