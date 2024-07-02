import 'package:app_bangiay_doan/page/mainpage.dart';
import 'package:app_bangiay_doan/page/trangchu/trangchubody.dart';
import 'package:app_bangiay_doan/page/trangchu/trangchuwidget.dart';
import 'package:flutter/material.dart';

import 'package:app_bangiay_doan/page/splash/splashscreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),  
    );
  }
}
