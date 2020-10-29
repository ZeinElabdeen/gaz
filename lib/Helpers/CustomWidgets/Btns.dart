import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../colors.dart';

Widget btn(BuildContext context, String txt, Function onTap) {
  return Padding(
    padding: const EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15),
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 55,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    ),
  );
}
Widget staticBtn(BuildContext context, String txt,  ) {
  return Padding(
    padding: const EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15),
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      decoration: BoxDecoration(
        color:Color(getColorHexFromStr("#BFBFBF"),),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
        ),
      ),
    ),
  );
}
Widget dialogBtn(BuildContext context, String txt, Function onTap) {
  return Padding(
    padding: const EdgeInsets.only(right: 50, left: 50, top: 15, bottom: 15),
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,

          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    ),
  );
}

Widget rejectBtn(BuildContext context, String txt, Function onTap) {
  return Padding(
    padding: const EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15),
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
   color: AppTheme.rejectButtonColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    ),
  );
}
