import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';


Widget dropDownContainer({BuildContext context, String txt, Function onTap}) {
  return Padding(
    padding: const EdgeInsets.only(right: 25, left: 25, bottom: 15),
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              color:AppTheme.secondaryColor,
              width: .5),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width - 140,
                  child: AutoSizeText(
                    txt,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 10,
                    maxFontSize: 13,
                    style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: AppTheme.secondaryColor,
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget locationContainer({BuildContext context, String txt, Function onTap}) {
  return Padding(
    padding: const EdgeInsets.only(right: 25, left: 25, bottom: 15),
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              color:AppTheme.secondaryColor,
              width: .5),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width - 140,
                  child: AutoSizeText(
                    txt,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 10,
                    maxFontSize: 13,
                    style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Icon(
                Icons.my_location,
                color: AppTheme.secondaryColor,
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget smallDropDownContainer({BuildContext context, String txt, Function onTap}) {
  return Padding(
    padding: const EdgeInsets.only(right: 10, left: 10, bottom: 15),
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width*.4,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              color:AppTheme.secondaryColor,
              width: .5),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width*.3,
                  child: AutoSizeText(
                    txt,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 10,
                    maxFontSize: 13,
                    style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ),
//              Expanded(
//                child: Container(),
//              ),
//              Icon(
//                Icons.keyboard_arrow_down,
//                color: AppTheme.secondaryColor,
//              ),
//              SizedBox(
//                width: 10,
//              )
            ],
          ),
        ),
      ),
    ),
  );
}
Widget addressDropDownContainer({BuildContext context, String txt, Function onTap}) {
  return Padding(
    padding: const EdgeInsets.only(right: 25, left: 25, bottom: 15),
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              color:AppTheme.secondaryColor,
              width: .5),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width - 140,
                  child: AutoSizeText(
                    txt,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 10,
                    maxFontSize: 13,
                    style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: AppTheme.secondaryColor,
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
