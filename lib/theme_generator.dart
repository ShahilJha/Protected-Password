import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeGenerator {
  static const kPrimaryColor = Colors.black45;
  static ThemeData generateThemeData() {
    return ThemeData(
      primaryColor: Color(0xFF333333),
      accentColor: Color(0xFF3b3b3b),
      scaffoldBackgroundColor: Color(0xFFa5a5a5),
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
