import 'package:flutter/material.dart';
import 'package:flutter_qr/qr/create_qr.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _buildSplash();
  }

  void _buildSplash() async {
    await Future.delayed(
      const Duration(milliseconds: 2000),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CreateQr()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/images/playstore.png',
            width: 100.0,
          ),
        ),
      ),
    );
  }
}
