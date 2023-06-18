import 'package:chatndong/screens/Home_screen.dart';
import 'package:chatndong/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp( GetMaterialApp
    (
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: Color(0xFF040303),
          appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF040303),
          titleTextStyle: TextStyle(color: Colors.white)
          ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Color(0xFF040303),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF040303),
          titleTextStyle: TextStyle(color: Colors.white)
        ),
        useMaterial3: true,
      ),
      home: const Login()
    );
  }
}

