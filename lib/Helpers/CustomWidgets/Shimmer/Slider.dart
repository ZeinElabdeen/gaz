import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget homeSliderShimmer() {
  return Shimmer.fromColors(
      baseColor: Colors.black12.withOpacity(0.1),
      highlightColor: Colors.black.withOpacity(0.2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        height: 200,
      ));
}
