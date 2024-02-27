import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../components/constants.dart';


ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor:HexColor('333739'),

  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      backgroundColor: HexColor('333739'),
      elevation: 0,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Jannah',
      ),

      iconTheme: const IconThemeData(
        color: Colors.white,

      ),

      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      )
  ),


  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 50,
    backgroundColor: HexColor('333738'),
  ),

  textTheme: const TextTheme(
    // bodySmall:TextStyle(
    //   fontSize: 15,
    //   fontWeight: FontWeight.w600,
    //   color: Colors.white,
    // ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.3
    ),
  ),
  fontFamily: 'Jannah',

  progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: defaultColor

  ),

);


ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontFamily: 'Jannah',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,


    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,

    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 50,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    // bodySmall:TextStyle(
    //   fontSize: 15,
    //   fontWeight: FontWeight.w600,
    //   color: Colors.black,
    // ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleSmall: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black,
        height: 1.3
    ),
  ),
  fontFamily: 'Jannah',

  progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: defaultColor

  ),


);