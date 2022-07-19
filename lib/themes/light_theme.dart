import 'package:flutter/material.dart';

import '../constants/colors.dart' as const_colors;
import '../constants/measures.dart' as const_measures;

final lightTheme = ThemeData(
  primaryColor: const_colors.torchRed,
  scaffoldBackgroundColor: const_colors.white,
  disabledColor: const_colors.tickleMePink,
  hintColor: const_colors.brightGray,
  shadowColor: const_colors.ghost.withOpacity(
    const_measures.smallOpacity,
  ),
  textTheme: _textTheme,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: const_colors.torchRed,
  ),
  dividerColor: const_colors.white,
  cardTheme: CardTheme(
    shadowColor: const_colors.ghost,
    color: const_colors.white,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        const_measures.midRadius,
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const_colors.white,
    titleTextStyle: _textTheme.headline5,
    elevation: 0,
    centerTitle: false,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: const_colors.torchRed,
    disabledColor: const_colors.torchRed.withOpacity(
      const_measures.smallOpacity,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: const_colors.torchRed,
    selectionColor: const_colors.torchRed.withOpacity(
      const_measures.smallOpacity,
    ),
    selectionHandleColor: const_colors.torchRed,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: _textTheme.bodyText2,
    hintStyle: _textTheme.subtitle1,
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(
      vertical: const_measures.smallPadding,
      horizontal: const_measures.smallPadding,
    ),
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
            return const_colors.torchRed.withOpacity(
              const_measures.smallOpacity,
            );
          }
          return const_colors.torchRed;
        },
      ),
      overlayColor: MaterialStateProperty.all(
        const_colors.white.withOpacity(
          const_measures.midOpacity,
        ),
      ),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            const_measures.smallRadius,
          ),
        ),
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
    color: const_colors.ebony,
  ),
  subtitle1: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: const_colors.brightGray,
  ),
  button: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  ),
);
