import 'package:flutter/material.dart';
import 'package:flutter_qr/screens/splash_screes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      title: 'Flutter QR',
      home: const SplashScreen(),
    );
  }
}
