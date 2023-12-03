import 'package:flutter/material.dart';
import 'package:flutter_qr/screens/splash_screes.dart';
import 'package:flutter_qr/web/login_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Colors.blue,
        ),
      ),
      title: 'QR Code Generation',
      home: const WebScreen(),
    );
  }
}
