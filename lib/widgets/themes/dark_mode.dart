import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark().copyWith(
    primary: Colors.orange, 
    secondary: Colors.white, 
   surface: Color.fromARGB(255, 3, 3, 3), 
    error: const Color(0xffd32f2f),
    onError: const Color.fromARGB(255, 17, 17, 17), 
    tertiary: Colors.white,

  ),
);
