//import 'package:flutter/material.dart';
//import 'package:shimmer/shimmer.dart';
//
//class SearchShimmer extends StatefulWidget {
//  @override
//  _SearchShimmerState createState() => _SearchShimmerState();
//}
//
//class _SearchShimmerState extends State<SearchShimmer> {
//  bool _enabled = true;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body:
//      Container(
//        width: double.infinity,
//        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//        child: Column(
//          mainAxisSize: MainAxisSize.max,
//          children: <Widget>[
//            Expanded(
//              child: Shimmer.fromColors(
//                baseColor: Colors.black12.withOpacity(0.1),
//                highlightColor: Colors.black.withOpacity(0.2),
//                enabled: _enabled,
//                child: GridView.builder(
//                  itemCount: 10,
//                  physics: NeverScrollableScrollPhysics(),
//                  shrinkWrap: true,
//                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                      crossAxisCount: 2,
//                      crossAxisSpacing: 1,
//                      mainAxisSpacing: 1,
//                      childAspectRatio: .85),
//                  itemBuilder: (_, __) {
//                    return Padding(
//                      padding: const EdgeInsets.only(bottom: 8.0),
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Container(
//                            height: 110,
//                            width: MediaQuery.of(context).size.width * .44,
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.only(
//                                topLeft: Radius.circular(20),
//                                topRight: Radius.circular(20),
//                              ),
//                              color: Colors.red,
//                            ),
//                          ),
//                          Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Padding(
//                                padding:
//                                    const EdgeInsets.only(top: 4, bottom: 4),
//                                child: Container(
//                                  width: MediaQuery.of(context).size.width * .2,
//                                  height: 8.0,
//                                  color: Colors.red,
//                                ),
//                              ),
//                              Container(
//                                width: MediaQuery.of(context).size.width * .2,
//                                height: 8.0,
//                                color: Colors.red,
//                              ),
//                              Padding(
//                                padding:
//                                    const EdgeInsets.only(top: 4, bottom: 4),
//                                child: Container(
//                                  width: MediaQuery.of(context).size.width * .2,
//                                  height: 8.0,
//                                  color: Colors.red,
//                                ),
//                              ),
//                            ],
//                          )
//                        ],
//                      ),
//                    );
//                  },
//                ),
//              ),
//            ),
//
//          ],
//        ),
//      ),
//    );
//  }
//}
