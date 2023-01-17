import 'package:flutter/material.dart';

String uri = 'https://fuel-assist.onrender.com'; 

class GlobalVar {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 255, 165, 0),
      Color.fromARGB(255, 255, 165, 0),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Colors.orange;
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
}
