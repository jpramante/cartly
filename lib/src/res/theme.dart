import 'package:flutter/material.dart';
import 'package:cartly/src/res/custom_colors.dart';

final appTheme = ThemeData(
  primarySwatch: Colors.blue,
  textTheme: TextTheme(
    headline1: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
      fontSize: 24,
      color: CustomColors.headerTextColor,
    ),
  ),
);
