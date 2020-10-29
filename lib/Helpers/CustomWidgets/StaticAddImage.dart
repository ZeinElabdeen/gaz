import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

Widget staticAddImagesContainer(BuildContext context, Function onTap) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: InkWell(
        onTap: onTap,
        child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.camera_alt,
                  color: Colors.blueGrey,
                  size: 30,
                ),
                Text(
                  translator.currentLanguage == "en"
                      ? "Add images"
                      : "اضافة صور",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                )
              ],
            )),
      ),
    ),
  );
}
