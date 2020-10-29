import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../colors.dart';

Widget txtFormField(
    {BuildContext context,
    Function validator,
    Function onSaved,
    String labelText,
    bool obscureText,
    TextInputType textInputType,
    TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.only(right: 25, left: 25),
    child: TextFormField(
      validator: validator,
      onSaved: onSaved,
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
            EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Color(
          getColorHexFromStr("#31C7F6"),
        ),
        enabled: true,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          backgroundColor: Color(
            getColorHexFromStr("#31C7F6"),
          ),
          fontSize: 12,
        ),
      ),
    ),
  );
}

Widget textFormField(
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
            EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            width: 1,
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

Widget txtField(
    {BuildContext context,
    Function validator,
    Function onSaved,
    String hintText,
    bool enabled,
    TextInputType textInputType,
    String prefix,
    bool obscureText,
    TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.only(right: 8, left: 8),
    child: TextFormField(
      validator: validator,
      controller: controller,
      onSaved: onSaved,
      enabled: enabled,
   //   textAlign: TextAlign.center,
      keyboardType: textInputType,
      obscureText: obscureText,
      style: TextStyle(
          fontFamily: AppTheme.fontName,
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 13),
      decoration: InputDecoration(
        errorStyle: TextStyle(
          fontFamily: AppTheme.fontName,
          color: Colors.red,
          fontSize: 13,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            prefix,
            width: 20,
            height: 20,
          ),
        ),
        contentPadding:
            EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.solid,
          ),
        ),
        filled: true,
        fillColor: Colors.transparent,
        enabled: true,
        labelText: hintText,
        labelStyle: TextStyle(
            color: AppTheme.secondaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      ),
    ),
  );
}

Widget staticTextFieldWithSuffix({
  BuildContext context,
  Function onTap,
  String hintText,
  String prefix,
  String suffix,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 8, left: 8),
    child: InkWell(
      onTap: onTap,
      child: TextFormField(
        enabled: false,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: AppTheme.fontName,
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 13),
        decoration: InputDecoration(
          errorStyle: TextStyle(
            fontFamily: AppTheme.fontName,
            color: Colors.red,
            fontSize: 13,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              prefix,
              width: 20,
              height: 20,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              suffix,
              width: 20,
              height: 20,
            ),
          ),
          contentPadding:
              EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            borderSide: BorderSide(
              width: 1,
              color: AppTheme.secondaryColor,
              style: BorderStyle.solid,
            ),
          ),
          filled: true,
          fillColor: Colors.transparent,
          enabled: true,
          hintText: hintText,
          hintStyle: TextStyle(
              color: AppTheme.secondaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}

Widget passwordTextFormField(
    {BuildContext context,
    Function validator,
    Function onSaved,
    String labelText,
    Icon prefixIcon,
    IconButton suffixIcon,
    bool obscureText,
    TextInputType textInputType,

    TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.only(right: 25, left: 25),
    child: TextFormField(
      validator: validator,
      onSaved: onSaved,
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      style: TextStyle(
          fontFamily: AppTheme.fontName,
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 15),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorStyle: TextStyle(
          fontFamily: AppTheme.fontName,
          color: Colors.red,
          fontSize: 14,
        ),
        contentPadding:
            EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Color(
          getColorHexFromStr("#31C7F6"),
        ),
        enabled: true,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          backgroundColor: Color(
            getColorHexFromStr("#31C7F6"),
          ),
          fontSize: 12,
        ),
      ),
    ),
  );
}

Widget passwordFormField(
    {BuildContext context,
    Function validator,
    Function onSaved,
    String labelText,
    Icon icon,
    bool obscureText,
    IconButton suffixIcon,
    TextInputType textInputType,
    TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.only(right: 25, left: 25),
    child: TextFormField(
      validator: validator,
      onSaved: onSaved,
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      style: TextStyle(
          fontFamily: AppTheme.fontName,
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 15),
      decoration: InputDecoration(
        prefixIcon: icon,
        errorStyle: TextStyle(
          fontFamily: AppTheme.fontName,
          color: Colors.red,
          fontSize: 14,
        ),
        contentPadding:
            EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Color(
          getColorHexFromStr("#F1F4F9"),
        ),
        enabled: true,
        labelText: labelText,
        suffixIcon: suffixIcon,
        labelStyle: TextStyle(
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.w800,
          backgroundColor: Color(
            getColorHexFromStr("#F1F4F9"),
          ),
          fontSize: 12,
        ),
      ),
    ),
  );
}

Widget updateFormField(
    {BuildContext context,
    Function validator,
    Function onSaved,
    String labelText,
    Icon icon,
    TextInputType textInputType,
    TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.only(right: 25, left: 25),
    child: TextFormField(
      validator: validator,
      onSaved: onSaved,
      controller: controller,
      keyboardType: textInputType,
      obscureText: false,
      style: TextStyle(
          fontFamily: AppTheme.fontName,
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 15),
      decoration: InputDecoration(
        prefixIcon: icon,
        errorStyle: TextStyle(
          fontFamily: AppTheme.fontName,
          color: Colors.red,
          fontSize: 14,
        ),
        contentPadding:
            EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Color(
          getColorHexFromStr("#F1F4F9"),
        ),
        enabled: true,
        labelText: labelText,
        labelStyle: TextStyle(
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.w800,
          backgroundColor: Color(
            getColorHexFromStr("#F1F4F9"),
          ),
          fontSize: 12,
        ),
      ),
    ),
  );
}

Widget prescriptionFormField(
    {BuildContext context,
    Function validator,
    Function onSaved,
    String labelText,
    TextInputType textInputType,
    TextEditingController controller}) {
  return Container(
    width: MediaQuery.of(context).size.width - 120,
    child: TextFormField(
      validator: validator,
      onSaved: onSaved,
      controller: controller,
      keyboardType: textInputType,
      obscureText: false,
      style: TextStyle(
          fontFamily: AppTheme.fontName,
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 15),
      decoration: InputDecoration(
        errorStyle: TextStyle(
          fontFamily: AppTheme.fontName,
          color: Colors.red,
          fontSize: 12,
        ),
        contentPadding:
            EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Color(
          getColorHexFromStr("#F1F4F9"),
        ),
        enabled: true,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Color(
            getColorHexFromStr("#A8BBCC"),
          ),
          fontWeight: FontWeight.w800,
          backgroundColor: Color(
            getColorHexFromStr("#F1F4F9"),
          ),
          fontSize: 12,
        ),
      ),
    ),
  );
}

Widget descriptionFormField(
    {BuildContext context,
    Function validator,
    Function onSaved,
    String labelText,
    TextInputType textInputType,
    TextEditingController controller}) {
  return Container(
    width: MediaQuery.of(context).size.width - 140,
    child: TextFormField(
      validator: validator,
      onSaved: onSaved,
      controller: controller,
      keyboardType: textInputType,
      obscureText: false,
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
            EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Color(
          getColorHexFromStr("#F8FAFC"),
        ),
        enabled: true,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Color(
            getColorHexFromStr("#A8BBCC"),
          ),
          fontWeight: FontWeight.w800,
          backgroundColor: Color(
            getColorHexFromStr("#F8FAFC"),
          ),
          fontSize: 12,
        ),
      ),
    ),
  );
}

Widget contactUsFormField(
    {BuildContext context,
    TextInputType textInputType,
    Function onSaved,
    Function validator,
    String labelText,
    TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.only(right: 20, left: 20),
    child: Container(
      child: TextFormField(
        obscureText: false,
        validator: validator,
        onSaved: onSaved,
        maxLines: 1,
        keyboardType: textInputType,
        controller: controller,
        style: TextStyle(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 15),
        decoration: InputDecoration(
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 13,
            ),
            contentPadding:
                EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            filled: true,
            fillColor: Color(getColorHexFromStr("#FFFFFF")),
            enabled: false,
            labelText: labelText,
            labelStyle: TextStyle(
                color: Color(getColorHexFromStr("#A5A5A5")),
                fontSize: 12,
                fontWeight: FontWeight.w600)),
      ),
    ),
  );
}

Widget descriptionTxtFormField(
    {BuildContext context,
    TextInputType textInputType,
    TextEditingController controller,
    Function onSaved,
    Function validator,
    String labelText}) {
  return Padding(
    padding: const EdgeInsets.only(right: 20, left: 20),
    child: Container(
      child: TextFormField(
        obscureText: false,
        validator: validator,

//            (String value) {
//          if (value.isEmpty) {
//            return "vvvv";
//          } else {
//            return null;
//          }
//        },

        onSaved: onSaved, controller: controller,
        maxLines: 3,
        keyboardType: textInputType,
        style: TextStyle(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 15),
        decoration: InputDecoration(
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 13,
            ),
            contentPadding:
                EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            filled: true,
            fillColor: Color(getColorHexFromStr("#FFFFFF")),
            enabled: false,
            alignLabelWithHint: true,
            labelText: labelText,
            labelStyle: TextStyle(
                color: Color(getColorHexFromStr("#A5A5A5")),
                fontSize: 12,
                fontWeight: FontWeight.w600)),
      ),
    ),
  );
}
