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
        colorSchemeSeed: ColorConstants.primary,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: ColorConstants.primary,
        brightness: Brightness.dark,
      ),
      home: const HomeScreen(),
    );
  }
}
