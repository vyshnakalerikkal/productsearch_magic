import 'package:flutter/material.dart';

// TextStyle constants for your app
class AppTextStyles {
  static const String _fontFamily = 'Poppins';

  static const TextStyle headline1 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: Colors.black,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Colors.black87,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: Colors.black87,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: Colors.black54,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: Colors.black45,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Colors.grey,
  );
}
