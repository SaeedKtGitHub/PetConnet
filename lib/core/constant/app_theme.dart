import 'package:pet_connect/core/constant/color.dart';
import 'package:flutter/material.dart';

//En
ThemeData themeEnglish = ThemeData(
  fontFamily: "PlayfairDisplay",
  primarySwatch: Colors.blue,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      color: AppColor.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    displayMedium: TextStyle(
      color: AppColor.black,
      fontWeight: FontWeight.bold,
      fontSize: 26,
    ),
    bodyMedium: TextStyle(
        height: 2,
        color: AppColor.grey,
        fontWeight: FontWeight.bold,
        fontSize: 14),
  ),
);

//Ar

ThemeData themeArabic = ThemeData(
  fontFamily: "Cairo",
  primarySwatch: Colors.blue,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      color: AppColor.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    displayMedium: TextStyle(
      color: AppColor.black,
      fontWeight: FontWeight.bold,
      fontSize: 26,
    ),
    bodyMedium: TextStyle(
        height: 2,
        color: AppColor.grey,
        fontWeight: FontWeight.bold,
        fontSize: 14),
  ),
);
