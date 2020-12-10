import 'package:flutter/material.dart';

enum MyThemeKeys { LIGHT, DARK}

class MyThemes {
  static final ThemeData lightTheme = ThemeData(
    backgroundColor: Colors.white,
  primaryColor: Colors.white,
   accentColor: Colors.grey,
    brightness: Brightness.light,
  );

  static final ThemeData darkTheme = ThemeData(

    backgroundColor: Color.fromARGB(255, 0, 0, 0),
    primaryColorDark: Color.fromARGB(255, 0, 0, 0),
    accentColor: Colors.black12,
    brightness: Brightness.dark,


  );



  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightTheme;
      case MyThemeKeys.DARK:
        return darkTheme;
      default:
        return lightTheme;
    }
  }
}