import 'package:flutter/material.dart';

import 'app_theme.dart';

Widget textField(
    {String labelText,
    Function validator,
    Function onSaved,
    Widget icon,
    bool enabled,
    bool obSecure,
    TextEditingController controller}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
          enabled: enabled,
          controller: controller,
          obscureText: obSecure,
          keyboardType: TextInputType.text,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              suffixIcon: icon,
              contentPadding: EdgeInsets.all(10),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.2),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
              labelText: labelText,
              labelStyle: TextStyle(fontSize: 13)),
          validator: validator,
          onSaved: onSaved),
    ),
  );
}

Widget addressesTextFormField(
    {BuildContext context,
    Function validator,
    Function onSaved,
    String labelText,
    int maxLines,
    bool obscureText,
    TextInputType textInputType,
    TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.only(right: 25, left: 25),
    child: TextFormField(
      validator: validator,
      onSaved: onSaved,
      maxLines: maxLines,
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      style: TextStyle(
          fontFamily: AppTheme.fontName,
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 15),
      decoration: InputDecoration(
        errorStyle: TextStyle(
          fontFamily: AppTheme.fontName,
          color: Colors.red,
          fontSize: 14,
        ),
        contentPadding:
            EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(
            width: .01,color: Colors.grey,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Colors.transparent,
        enabled: true,
        labelText: labelText,
        alignLabelWithHint: true,
        labelStyle: TextStyle(
          color: AppTheme.secondaryColor,
          fontWeight: FontWeight.w600,
          backgroundColor: Colors.transparent,
          fontSize: 12,
        ),
      ),
    ),
  );
}
