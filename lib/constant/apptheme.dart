// This code defines two ThemeData objects (themeEnglish and themeArabic) 
// to support multilingual UI design. Each theme sets a different font family 
// (PlayfairDisplay for English, Cairo for Arabic) while keeping consistent 
// text styles and color scheme across the app.

import 'package:flutter/material.dart';

ThemeData themeEnglish =  ThemeData(
        fontFamily: "PlayfairDisplay",
        textTheme: TextTheme(
          labelMedium:TextStyle( fontSize: 30,
               fontWeight: FontWeight.bold,
               color: Colors.black) ,
         labelSmall: TextStyle( fontSize: 20,
               fontWeight: FontWeight.bold,
               color: Colors.black),
          titleMedium: TextStyle( fontSize: 30,
               fontWeight: FontWeight.bold,
               color: Colors.white),
          bodyMedium: TextStyle(height: 1.5,
               fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      );
      ThemeData themeArabic =  ThemeData(
        fontFamily: "Cairo",
        textTheme: TextTheme(
          labelMedium:TextStyle( fontSize: 30,
               fontWeight: FontWeight.bold,
               color: Colors.black) ,
         labelSmall: TextStyle( fontSize: 20,
               fontWeight: FontWeight.bold,
               color: Colors.black),
          titleMedium: TextStyle( fontSize: 30,
               fontWeight: FontWeight.bold,
               color: Colors.white),
          bodyMedium: TextStyle(height: 1.5,
               fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      );




