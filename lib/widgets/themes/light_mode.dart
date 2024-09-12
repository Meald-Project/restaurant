import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light().copyWith(
    primary: Colors.black54,
    secondary: const Color(0xff000000),
    surface: Color.fromARGB(255, 245, 245, 245),
    error: const Color(0xffd32f2f),
    onError: Colors.white,
    tertiary: Colors.black54,
  ),
);
