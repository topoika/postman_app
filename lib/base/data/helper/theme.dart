import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

Color primaryColor = const Color.fromARGB(255, 75, 247, 155);

// colors/

var primarySwatch = MaterialColor(primaryColor.value, {
  50: primaryColor.withOpacity(0.1),
  100: primaryColor.withOpacity(0.2),
  200: primaryColor.withOpacity(0.3),
  300: primaryColor.withOpacity(0.4),
  400: primaryColor.withOpacity(0.5),
  500: primaryColor.withOpacity(0.6),
  600: primaryColor.withOpacity(0.7),
  700: primaryColor.withOpacity(0.8),
  800: primaryColor.withOpacity(0.9),
  900: primaryColor.withOpacity(1.0),
});

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primarySwatch: primarySwatch,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: primarySwatch),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  primaryColor: btnColor,
  fontFamily: "DMSans",
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFFFFFF),
    iconTheme: IconThemeData(color: Color(0xFF2E3033)),
    systemOverlayStyle:
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
  ),
  cardTheme: const CardTheme(
    color: Colors.white,
    shadowColor: Colors.grey,
    elevation: 4,
  ),
);
