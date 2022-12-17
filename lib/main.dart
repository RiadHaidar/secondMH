import 'package:flutter/material.dart';

import 'homePage.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.amber),
            appBarTheme: AppBarTheme(
              color:  Colors.amber,
            ),
            fontFamily: 'Poppins'), home: Homepage());
  }
}
