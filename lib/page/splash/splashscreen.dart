import 'package:flutter/material.dart';
import 'dart:async';
import 'package:app_bangiay_doan/page/splash/horizontalscrool.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    // Thiết lập thời gian chờ trước khi chuyển sang màn hình chính
    Timer(const Duration(seconds: 3), () {
      // Chuyển sang màn hình chính
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HorizontalScroll()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/Logo1.png', // Đường dẫn đến ảnh splash của bạn
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
