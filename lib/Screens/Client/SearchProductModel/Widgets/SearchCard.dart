import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:master/Helpers/app_theme.dart';
import '../model.dart';

class SearchProductCard extends StatelessWidget {
  final SearchItem keyWord;
  final Function onTap;
  final Function onAddToCartTapped;
  const SearchProductCard({
    Key key,
    @required this.keyWord,
    @required this.onTap,
    @required this.onAddToCartTapped,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              border: Border.all(width: .01)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Center(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                    image: DecorationImage(
                        image: NetworkImage(
                          keyWord.image,
                        ),
                        fit: BoxFit.cover),
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, right: 6, left: 6),
                child: Container(
                  width: MediaQuery.of(context).size.width * .45,
                  child: Text(
                    keyWord.name,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: AppTheme.boldFont,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.primaryColor),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6, bottom: 6, left: 6),
                child: Text(
                  "${keyWord.price} ${translator.currentLanguage == "en" ? "Sar" : "رس"}",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: AppTheme.boldFont,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.priceColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 12),
                child: InkWell(
                  onTap: onAddToCartTapped,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .8,
                    height: 33,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/icons/add_cart.png",
                          width: 25,
                          height: 25,
                        ),
                        Text(
                          translator.currentLanguage == "en"
                              ? "Add to cart"
                              : "أضف للسلة",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget searchHereCard(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * .8,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 20),
          child: CircleAvatar(
              backgroundColor: AppTheme.primaryColor,
              radius: 70,
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 100,
              )),
        ),
        Text(
          translator.currentLanguage == "en" ? "search here" : "ابحث هنا",
          style: TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w800,
              fontFamily: AppTheme.boldFont),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
