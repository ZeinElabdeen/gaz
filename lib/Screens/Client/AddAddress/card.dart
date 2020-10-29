import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:master/Helpers/app_theme.dart';

Widget addressText(
    {BuildContext context, Function onEditTapped, String address}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 30,
        ),
        Container(
            width: MediaQuery.of(context).size.width - 90,
            child: Text(
              address,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            )),
        Expanded(
          child: Container(),
        ),
        InkWell(
            onTap: onEditTapped,
            child: Image.asset(
              "assets/icons/edit.png",
              width: 20,
              height: 20,
            )),
        SizedBox(
          width: 30,
        ),
      ],
    ),
  );
}
