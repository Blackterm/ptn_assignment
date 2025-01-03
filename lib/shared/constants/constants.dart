import 'package:flutter/material.dart';

class AppENV {
  static const String baseUrl = 'https://assign-api.piton.com.tr/api/rest/';
  static const String logo = 'assets/Logo.png';
  static const String placeHolder = 'assets/placeholder.png';
  static const String like = 'assets/like.png';
  static const String unlike = 'assets/unlike.png';
}

class AppColors {
  /// App primary color
  static const Color primary = Color(0xff1DA1F2);

  /// App secondary color
  static const Color error = Color(0xffFC698C);

  /// App black color
  static const Color black = Color(0xff14171A);

  /// App white color
  static const Color white = Color(0xffffffff);

  /// Light grey color
  static const Color lightGrey = Color(0xffAAB8C2);

  /// Extra Light grey color
  static const Color extraLightGrey = Color(0xffE1E8ED);

  /// Button color
  static const Color buttonPrimary = Color(0xffEF6B4A);

  /// Background primary light
  static const Color backgroundPrimaryLight =
      Color.fromARGB(255, 238, 238, 255);

  /// Background primary dark
  static const Color backgroundPrimaryDark = Color(0xff6251DD);

  /// Background primary dark
  static const Color splashPrimaryDark = Color(0xff1D1D4E);
}

class AppTextStyles {
  /// Text style for body
  static const TextStyle bodyLg = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodySm = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle bodyXs = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
  );

  /// Text style for heading

  static const TextStyle h1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
}
