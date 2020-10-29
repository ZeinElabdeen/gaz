import 'package:flutter/material.dart';
import 'package:master/Helpers/app_theme.dart';
import 'package:master/Helpers/colors.dart';

Widget clientHomeCard(
    {BuildContext context, String img, backgroundImg, txt, Function onTap}) {
  return Padding(
    padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
    child: InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(
            image: NetworkImage(backgroundImg),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .6,
              child: Text(
                txt,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    fontFamily: AppTheme.boldFont),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
                height: 120,
                width: MediaQuery.of(context).size.width * .3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(25),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.01, 0.9],
                    colors: [
                      Color(
                        getColorHexFromStr("F9B922"),
                      ),
                      Color(
                        getColorHexFromStr("#F36E24"),
                      ),
                    ],
                  ),
                ),
                child: Container(
                  child: Image.network(
                    img,
                    fit: BoxFit.contain,
                  ),
                )),
          ],
        ),
      ),
    ),
  );
}
