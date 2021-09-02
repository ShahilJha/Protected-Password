import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeGenerator {
  static const kPrimaryColor = Colors.blue;
  static ThemeData generateThemeData() {
    return ThemeData(
      primaryColor: kPrimaryColor,
      accentColor: Colors.blueGrey,
      scaffoldBackgroundColor: Color(0xFFF3F3F3),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      buttonTheme: _getButtonThemeData(),
      dividerTheme: _getDividerThemeData(),
    );
  }

  static DividerThemeData _getDividerThemeData() {
    return DividerThemeData().copyWith(
      space: 50.r,
      thickness: 1.5,
      indent: 100.r,
      endIndent: 100.r,
      color: Colors.grey,
    );
  }

  static ButtonThemeData _getButtonThemeData() {
    return ButtonThemeData().copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      textTheme: ButtonTextTheme.primary,
    );
  }
}
