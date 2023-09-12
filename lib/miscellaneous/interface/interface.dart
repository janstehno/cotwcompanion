// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:flutter/material.dart';

class Interface {
  static const String version = "1.7.3";
  static const int greatOneId = 100;
  static const Color alwaysDark = ff0d;
  static const Color alwaysLight = fff5;
  static const Color shadow = ff42;

  static bool _darkMode = false;
  static double accentBorderWidth = 0;

  static Color primary = Colors.transparent;
  static Color accent = Colors.transparent;
  static Color dark = Colors.transparent;
  static Color light = Colors.transparent;
  static Color accentBorder = Colors.transparent;
  static Color body = Colors.transparent;
  static Color dropDown = Colors.transparent;
  static Color odd = Colors.transparent;
  static Color even = Colors.transparent;
  static Color title = Colors.transparent;
  static Color sectionTitle = Colors.transparent;
  static Color search = Colors.transparent;
  static Color tag = Colors.transparent;
  static Color nothing = Colors.transparent;
  static Color common = Colors.transparent;
  static Color other = Colors.transparent;
  static Color disabled = Colors.transparent;
  static Color anatomyBody = Colors.transparent;
  static Color anatomyBones = Colors.transparent;

  static ColorScheme omniDatePickerScheme = const ColorScheme.dark();

  static const Color grey = Color(0xFFBDBDBD);
  static const Color pink = Color(0xFFC2185B);
  static const Color red = Color(0xFFE53935);
  static const Color redorange = Color(0xFFFF5722);
  static const Color orange = Color(0xFFFF9800);
  static const Color yellow = Color(0xFFFFC107);
  static const Color lightyellow = Color(0xFFFDD835);
  static const Color grassgreen = Color(0xFFCDDC39);
  static const Color lightgreen = Color(0xFF8BC34A);
  static const Color green = Color(0xFF4CAF50);
  static const Color teal = Color(0xFF009688);
  static const Color lightblue = Color(0xFF00ACC1);
  static const Color blue = Color(0xFF2196F3);
  static const Color darkblue = Color(0xFF1976D2);
  static const Color deepblue = Color(0xFF0D47A1);
  static const Color purple = Color(0xFF4527A0);
  static const Color darkpink = Color(0xFF9C27B0);
  static const Color lightbrown = Color(0xFF8D6E63);
  static const Color brown = Color(0xFF4E342E);

  static const Color stop = red;
  static const Color play = blue;
  static const Color selected = red;
  static const Color unselected = lightgreen;
  static const Color trophyBronze = lightbrown;
  static const Color trophySilver = grey;
  static const Color trophyGold = orange;
  static const Color trophyDiamond = blue;
  static const Color uncommon = lightgreen;
  static const Color rare = blue;
  static const Color veryrare = orange;
  static const Color mission = red;
  static const Color feed = lightgreen;
  static const Color drink = blue;
  static const Color rest = orange;
  static const Color male = blue;
  static const Color female = red;
  static const Color summer = yellow;
  static const Color winter = blue;
  static const Color field = orange;
  static const Color forest = lightgreen;
  static const Color plains = orange;
  static const Color lowlands = lightgreen;
  static const Color hills = yellow;
  static const Color mountains = blue;
  static const Color trophyNoneBackground = ff75;
  static const Color trophyBronzeBackground = trophyBronze;
  static const Color trophySilverBackground = grey;
  static const Color trophyGoldBackground = trophyGold;
  static const Color trophyDiamondBackground = trophyDiamond;

  static const Color ffff = Color(0xFFFFFFFF);
  static const Color fffe = Color(0xFFFEFEFE); //odd, body
  static const Color fff5 = Color(0xFFF5F5F5); //even, dark, light, accent, sectionTitle
  static const Color ffef = Color(0xFFEFEFEF); //title
  static const Color ffee = Color(0xFFEEEEEE); //dropDown, search, nothing, other, common
  static const Color ffe0 = Color(0xFFE0E0E0);
  static const Color ffcc = Color(0xFFCCCCCC); //tag
  static const Color ffbd = Color(0xFFBDBDBD); //anatomy
  static const Color ff9e = Color(0xFF9E9E9E); //disabled
  static const Color ff75 = Color(0xFF757575);
  static const Color ff61 = Color(0xFF616161); //disabled
  static const Color ff42 = Color(0xFF424242); //shadow, anatomy
  static const Color ff23 = Color(0xFF232323); //tag
  static const Color ff21 = Color(0xFF212121);
  static const Color ff17 = Color(0xFF171717); //dropDown, search, nothing, other, common
  static const Color ff12 = Color(0xFF121212); //title
  static const Color ff0d = Color(0xFF0D0D0D); //even, dark, light, accent, sectionTitle
  static const Color ff06 = Color(0xFF060606); //odd, body
  static const Color ff00 = Color(0xFF000000);

  //appbar
  static TextStyle s28w600c(Color color) => TextStyle(color: color, fontSize: 28, fontWeight: FontWeight.w600, fontFamily: 'Condensed');

  //homeTitle
  static TextStyle s24w600c(Color color) => TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.w600, fontFamily: 'Condensed');

  //bigTitle
  static TextStyle s20w600c(Color color) => TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Condensed');

  //homeText
  static TextStyle s18w400c(Color color) => TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: 'Condensed');

  //mediumTitle
  static TextStyle s18w600c(Color color) => TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Condensed');

  //smallTitle
  static TextStyle s16w600c(Color color) => TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Condensed');

  //importantText, stats, buttons, sliders
  static TextStyle s18w500n(Color color) => TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'Normal');

  //itemTitle
  static TextStyle s18w300n(Color color) => TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w300, fontFamily: 'Normal');

  //bigTag, richText
  static TextStyle s16w500n(Color color) => TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Normal');

  //generalText
  static TextStyle s16w300n(Color color) => TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w300, fontFamily: 'Normal');

  //mediumTag
  static TextStyle s14w500n(Color color) => TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Normal');

  //snackBar, logText, loadoutText
  static TextStyle s14w300n(Color color) => TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w300, fontFamily: 'Normal');

  //smallTag
  static TextStyle s12w500n(Color color) => TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'Normal');

  //smallText, subTextTitle
  static TextStyle s12w300n(Color color) => TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w300, fontFamily: 'Normal');

  static void setColors(bool darkMode) {
    _darkMode = darkMode;
    if (darkMode) {
      //DARK MODE
      body = ff06;
      odd = ff06;
      even = ff0d;
      title = ff12;
      sectionTitle = ff0d;
      light = ff0d;
      dark = fff5;
      search = ff17;
      tag = ff23;
      dropDown = ff17;
      nothing = ff17;
      other = ffee;
      common = ffee;
      anatomyBones = ffbd;
      anatomyBody = ff42;
      disabled = ff61;
      omniDatePickerScheme = ColorScheme(
        brightness: Brightness.dark,
        primary: Interface.primary,
        onPrimary: Interface.accent,
        secondary: Colors.transparent,
        onSecondary: Colors.transparent,
        error: Colors.transparent,
        onError: Colors.transparent,
        background: Colors.transparent,
        onBackground: Colors.transparent,
        surface: Colors.transparent,
        onSurface: Interface.alwaysLight,
      );
    } else {
      //LIGHT MODE
      body = fffe;
      odd = fffe;
      even = fff5;
      title = ffef;
      sectionTitle = fff5;
      light = fff5;
      dark = ff0d;
      search = ffee;
      dropDown = ffee;
      tag = ffcc;
      nothing = ffee;
      other = ff17;
      common = ff17;
      anatomyBones = ff42;
      anatomyBody = ffbd;
      disabled = ff9e;
      omniDatePickerScheme = ColorScheme(
        brightness: Brightness.light,
        primary: Interface.primary,
        onPrimary: Interface.accent,
        secondary: Colors.transparent,
        onSecondary: Colors.transparent,
        error: Colors.transparent,
        onError: Colors.transparent,
        background: Colors.transparent,
        onBackground: Colors.transparent,
        surface: Colors.transparent,
        onSurface: Interface.alwaysDark,
      );
    }
  }

  static void setPrimaryColor(Color primaryColor) {
    primary = primaryColor;

    accentBorder = Colors.transparent;
    accentBorderWidth = 0;

    if (primaryColor == deepblue || primaryColor == purple || primaryColor == brown) {
      accent = alwaysLight;
      if (_darkMode) {
        accentBorder = alwaysLight;
        accentBorderWidth = 0.5;
      }
    } else {
      accent = alwaysDark;
    }
  }
}
