import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:localize_and_translate/localize_and_translate.dart';

import '../app_theme.dart';

dynamic openImagePicker(
    {BuildContext context, Function onGalleryTapped, Function onCameraTapped}) {
  showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoButton(
            child: Text(
              translator.currentLanguage == "en" ? "Cancel" : "الغاء",
              style: TextStyle(
                fontFamily: AppTheme.fontName,
                color: AppTheme.primaryColor,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            CupertinoButton(
                child: Row(
                  children: <Widget>[
                    Icon(
                      CupertinoIcons.photo_camera_solid,
                      color: AppTheme.primaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      translator.currentLanguage == "en"
                          ? "Camera"
                          : "الكاميرا",
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 15,
                        fontFamily: AppTheme.fontName,
                      ),
                    ),
                  ],
                ),
                onPressed: onCameraTapped),
            CupertinoButton(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.insert_photo,
                      color: AppTheme.primaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      translator.currentLanguage == "en"
                          ? "Gallery"
                          : "الاستوديو",
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 15,
                        fontFamily: AppTheme.fontName,
                      ),
                    ),
                  ],
                ),
                onPressed: onGalleryTapped),
          ],
        );
      });
}
