import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:master/Helpers/app_theme.dart';

Widget addressCard(
    {BuildContext context,
    Function onDeleteTapped,
    Function onEditTapped,
    Function onMapTapped,
    String addressType,
    String flatNumber,
    double lat,
    lng,
    String streetNumber,
    Function onCardTapped}) {
  return InkWell(
    onTap: onCardTapped,
    child: Padding(
      padding: const EdgeInsets.only(right: 12, left: 12, top: 10),
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: Row(
            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: <Widget>[
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage(
                          "assets/icons/location.png",
                        ),
                        height: 25,
                        width: 15,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 170,
                        child: Text(
                          addressType,
                          style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 150,
                    child: Text(flatNumber,
                        style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 150,
                    child: Text(
                      streetNumber,
                      style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: onEditTapped,
                          child: Image(
                            image: AssetImage(
                              "assets/icons/edit.png",
                            ),
                            height: 30,
                            width: 15,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        InkWell(
                          onTap: onDeleteTapped,
                          child: Image(
                            image: AssetImage(
                              "assets/icons/delete.png",
                            ),
                            height: 20,
                            width: 15,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: onMapTapped,
                        child: Container(
                          width: 100,
                          height: 70,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5)),
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: LatLng(lat, lng), zoom: 10.0),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                width: 6,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
