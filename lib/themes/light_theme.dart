import 'package:flutter/material.dart';

import '../constants/colors.dart' as const_colors;

final lightTheme = ThemeData(
  primaryColor: const_colors.torchRed,
  scaffoldBackgroundColor: const_colors.white,
  disabledColor: const_colors.tickleMePink,
  hintColor: const_colors.brightGray,
  textTheme: _textTheme,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: const_colors.torchRed,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const_colors.white,
    titleTextStyle: _textTheme.headline5,
    elevation: 0,
    centerTitle: false,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: const_colors.torchRed,
    disabledColor: const_colors.torchRed.withOpacity(0.1),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: _textTheme.subtitle1,
    errorStyle: const TextStyle(
      color: const_colors.torchRed,
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: const_colors.ghost,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: const_colors.ghost,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: const_colors.tickleMePink,
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: const_colors.torchRed,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(_textTheme.button),
      foregroundColor: MaterialStateProperty.all(const_colors.white),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return const_colors.torchRed.withOpacity(0.1);
          }
          return const_colors.torchRed;
        },
      ),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.all(6),
      ),
    ),
  ),
);

const _textTheme = TextTheme(
  headline4: TextStyle(
    fontSize: 29,
    fontWeight: FontWeight.w600,
    color: const_colors.torchRed,
  ),
  headline5: TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: const_colors.ebony,
  ),
  headline6: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  ),
  bodyText1: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: const_colors.ebony,
  ),
  bodyText2: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: const_colors.brightGray,
  ),
  subtitle1: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: const_colors.ghost,
  ),
  button: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  ),
);
