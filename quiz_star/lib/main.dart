import 'package:flutter/material.dart';
import 'package:quiz_star/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Quiz Star",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: splashscreen(),
    );
  }
}
