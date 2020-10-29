import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/app_theme.dart';

class SearchScreenAppBar extends StatelessWidget {
  final Function onChanged;
  final TextEditingController textEditingController;
  const SearchScreenAppBar(
      {Key key, this.onChanged, this.textEditingController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppTheme.primaryColor),
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  child: TextField(
                    controller: textEditingController,
                    textInputAction: TextInputAction.search,
                    onChanged: onChanged,
                    autofocus: true,
                    onSubmitted: (String _) {},
                    style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      color: AppTheme.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: translator.currentLanguage == 'ar'
                          ? "ابحث هنا"
                          : "Search here",
                      hintStyle: TextStyle(
                          fontFamily: AppTheme.fontName,
                          color: AppTheme.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                      contentPadding: EdgeInsets.only(
                          left: 10.0, top: 15, bottom: 10, right: 10.0),
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: Icon(
                        Icons.search,
                        color: AppTheme.primaryColor,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
