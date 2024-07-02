import 'package:app_bangiay_doan/page/mainpage.dart';
import 'package:app_bangiay_doan/page/trangchu/trangchubody.dart';
import 'package:app_bangiay_doan/page/trangchu/trangchuwidget.dart';
import 'package:app_bangiay_doan/page/login-register/login_screen.dart';
import 'package:app_bangiay_doan/page/login-register/register_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
