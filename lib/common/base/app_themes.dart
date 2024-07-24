import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();

  //Font
  static String lightFont = "Arimo";
  static String darkFont = "Arimo";

  //Primary
  static const Color _lightPrimaryColor = Color(0xffffffff);
  static const Color _darkPrimaryColor = Color(0xFF1a222d);

  //Secondary
  static const Color _lightSecondaryColor = Color(0xFFd74315);
  static const Color _darkSecondaryColor = Color(0xFFd74315);

  //Background
  static const Color _lightBackgroundColor = Color(0xffffffff);
  static const Color _darkBackgroundColor = Color(0xFF1a222d);

  //Text
  static const Color _lightTextColor = Color(0xff000000);
  static const Color _darkTextColor = Color(0xffffffff);

  //Border
  static const Color _lightBorderColor = Colors.grey;
  static const Color _darkBorderColor = Colors.grey;

  //Icon
  static const Color _lightIconColor = Color(0xff000000);
  static const Color _darkIconColor = Color(0xffffffff);

  //Text themes
  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 96.0, color: _lightTextColor),
    displayMedium: TextStyle(fontSize: 60.0, color: _lightTextColor),
    displaySmall: TextStyle(fontSize: 48.0, color: _lightTextColor),
    headlineLarge: TextStyle(fontSize: 34.0, color: _lightTextColor),
    headlineMedium: TextStyle(fontSize: 24.0, color: _lightTextColor),
    headlineSmall: TextStyle(fontSize: 20.0, color: _lightTextColor, fontWeight: FontWeight.w500),
    titleLarge: TextStyle(fontSize: 16.0, color: _lightTextColor),
    titleMedium: TextStyle(fontSize: 14.0, color: _lightTextColor, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16.0, color: _lightTextColor),
    bodyMedium: TextStyle(fontSize: 14.0, color: _lightTextColor),
    labelLarge: TextStyle(fontSize: 14.0, color: _lightTextColor, fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontSize: 12.0, color: _lightTextColor),
    labelSmall: TextStyle(fontSize: 14.0, color: _lightTextColor),
  );

  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 96.0, color: _darkTextColor),
    displayMedium: TextStyle(fontSize: 60.0, color: _darkTextColor),
    displaySmall: TextStyle(fontSize: 48.0, color: _darkTextColor),
    headlineLarge: TextStyle(fontSize: 34.0, color: _darkTextColor),
    headlineMedium: TextStyle(fontSize: 24.0, color: _darkTextColor),
    headlineSmall: TextStyle(fontSize: 20.0, color: _darkTextColor, fontWeight: FontWeight.w500),
    titleLarge: TextStyle(fontSize: 16.0, color: _darkTextColor),
    titleMedium: TextStyle(fontSize: 14.0, color: _darkTextColor, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16.0, color: _darkTextColor),
    bodyMedium: TextStyle(fontSize: 14.0, color: _darkTextColor),
    labelLarge: TextStyle(fontSize: 14.0, color: _darkTextColor, fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontSize: 12.0, color: _darkTextColor),
    labelSmall: TextStyle(fontSize: 14.0, color: _darkTextColor),
  );

  ///Light theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _lightPrimaryColor,
    // accentColor: _lightSecondaryColor,
    fontFamily: darkFont,
    scaffoldBackgroundColor: _lightBackgroundColor,
    appBarTheme: AppBarTheme(
      color: _lightBackgroundColor,
      iconTheme: IconThemeData(color: _lightIconColor),
      titleTextStyle: _darkTextTheme.headlineSmall?.copyWith(color: _darkIconColor),
      toolbarTextStyle: _darkTextTheme.bodyMedium?.copyWith(color: _darkIconColor),
    ),
    iconTheme: IconThemeData(
      color: _lightIconColor,
    ),
    textTheme: _lightTextTheme,
    dividerTheme: DividerThemeData(
      color: Colors.grey,
    ),

    colorScheme:  ColorScheme.light(),

    // ColorScheme.fromSwatch(
    //   primarySwatch: Colors.blue,  // 替换为你的主色
    //   brightness: Brightness.dark,
    // ).copyWith(
    //   secondary: _lightSecondaryColor,  // 相当于 accentColor
    //   // background: _darkBackgroundColor,
    //   primary: _lightPrimaryColor,
    // ),
  );

  ///Dark theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _darkPrimaryColor,
    // accentColor: _darkSecondaryColor,
    fontFamily: darkFont,
    scaffoldBackgroundColor: _darkBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: _darkBackgroundColor,
      iconTheme: IconThemeData(color: _darkIconColor),
      titleTextStyle: _darkTextTheme.headlineSmall?.copyWith(color: _darkIconColor),
      toolbarTextStyle: _darkTextTheme.bodyMedium?.copyWith(color: _darkIconColor),

    ),
    iconTheme: IconThemeData(
      color: _darkIconColor,
    ),
    textTheme: _darkTextTheme,
    dividerTheme: DividerThemeData(
      color: Colors.grey,
    ),

    colorScheme:ColorScheme.dark(),

    // ColorScheme.fromSwatch(
    //   primarySwatch: Colors.blue,  // 替换为你的主色
    //   brightness: Brightness.dark,
    // ).copyWith(
    //   secondary: _darkSecondaryColor,  // 相当于 accentColor
    //   // background: _darkBackgroundColor,
    //   primary: _darkPrimaryColor,
    // ),
  );
}
