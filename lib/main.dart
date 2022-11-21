import 'package:based_bml/constants.dart';
import 'package:based_bml/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Based BML',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: ColorConstants.bmlRed,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: ColorConstants.lightColorScheme.primary,
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: ColorConstants.bmlRed,
        brightness: Brightness.dark,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: ColorConstants.darkColorScheme.primary,
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
