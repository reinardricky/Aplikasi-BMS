import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData light(BuildContext context) => ThemeData(
      primaryColor: Colors.yellow[200],
      brightness: Brightness.light,
      fontFamily: 'PlusJakartaSans',
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: const TextTheme(
        bodyText1:TextStyle(color:Colors.black),
        bodyText2:TextStyle(color:Colors.black),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
        foregroundColor: Colors.black,
        color: Colors.yellow[200],
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.yellow[200],
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.yellow[200], // background (button) color
          onPrimary: Colors.black, // foreground (text) color
        ),
      ),
      // bottomNavigationBarTheme: ,
      colorScheme: const ColorScheme.light(
        background: Colors.white60,
      ));
  static ThemeData dark(BuildContext context) => ThemeData(
      primaryColor: Colors.black12,
      brightness: Brightness.dark,
      fontFamily: 'PlusJakartaSans',
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(color:Colors.white),
        bodyText2:TextStyle(color:Colors.white),
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
        foregroundColor: Colors.white,
        color: Colors.black12,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme.dark(
        background: Colors.black12,
      ),

  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
      return themeMode == ThemeMode.dark;
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}