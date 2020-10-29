import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'app_theme.dart';


Widget authLoader(){
  return Center(
    child: SpinKitHourGlass(
      size: 40,
      color: AppTheme.primaryColor,
    ),
  );
}

Widget loader(){
  return Center(
    child: SpinKitHourGlass(
      size: 40,
      color: AppTheme.primaryColor,
    ),
  );
}


Widget dialogLoader(){
  return Center(
    child: SpinKitHourGlass(
      size: 40,
      color: AppTheme.primaryColor,
    ),
  );
}

