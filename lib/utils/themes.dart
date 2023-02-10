import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/gen/assets.gen.dart';

class Themes {
  static final String _neuzeit = Assets.fonts.neuzeit;

  static AppBarTheme get appBarTheme => AppBarTheme(
        toolbarTextStyle: ThemeData.light()
            .textTheme
            .copyWith(
              titleLarge: TextStyle(
                fontFamily: _neuzeit,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
            .bodyMedium,
        titleTextStyle: ThemeData.light()
            .textTheme
            .copyWith(
              titleLarge: TextStyle(
                fontFamily: _neuzeit,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
            .titleLarge,
      );

  static TextTheme get textTheme => TextTheme(
        displayLarge: TextStyle(
          fontFamily: _neuzeit,
          fontWeight: FontWeight.bold,
          fontSize: 34,
          color: Colors.white,
        ),
        displayMedium: TextStyle(
          fontFamily: _neuzeit,
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
        displaySmall: TextStyle(
          fontFamily: _neuzeit,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
        headlineMedium: TextStyle(
          fontFamily: _neuzeit,
          fontWeight: FontWeight.normal,
          fontSize: 22,
          color: Colors.white,
        ),
        headlineSmall: TextStyle(
          fontFamily: _neuzeit,
          fontWeight: FontWeight.normal,
          fontSize: 20,
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          fontFamily: _neuzeit,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontFamily: _neuzeit,
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: Colors.white,
        ),
        titleSmall: TextStyle(
          fontFamily: _neuzeit,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          fontFamily: _neuzeit,
          fontWeight: FontWeight.normal,
          fontSize: 18,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontFamily: _neuzeit,
          fontWeight: FontWeight.normal,
          fontSize: 17,
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          fontFamily: _neuzeit,
          fontWeight: FontWeight.normal,
          fontSize: 16,
          color: Colors.white,
        ),
        labelLarge: TextStyle(
          fontFamily: _neuzeit,
          fontWeight: FontWeight.normal,
          fontSize: 15,
          color: Colors.white,
        ),
        labelMedium: TextStyle(
          fontFamily: _neuzeit,
          fontWeight: FontWeight.normal,
          fontSize: 14,
          color: Colors.white,
        ),
      );

  static ButtonThemeData get buttonTheme => const ButtonThemeData(
        buttonColor: Colors.white70,
        disabledColor: Colors.white60,
        focusColor: Colors.white,
        hoverColor: Colors.white,
        highlightColor: Colors.white,
        splashColor: Colors.white,
        materialTapTargetSize: MaterialTapTargetSize.padded,
      );

  static ElevatedButtonThemeData get elevatedButtonThemeData =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(textTheme.titleMedium),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
      );

  static TextButtonThemeData get textButtonThemeData => TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(textTheme.labelLarge),
          foregroundColor: MaterialStateProperty.all(Colors.white54),
        ),
      );

  static InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        labelStyle: textTheme.bodyMedium?.copyWith(color: Colors.white30),
        floatingLabelStyle:
            textTheme.bodyMedium?.copyWith(color: Colors.white30),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      );
}
