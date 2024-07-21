import 'package:app_bangiay_doan/page/history/history_screen.dart';
import 'package:app_bangiay_doan/page/mainpage.dart';
import 'package:app_bangiay_doan/page/trangchu/trangchubody.dart';
import 'package:app_bangiay_doan/page/trangchu/trangchuwidget.dart';
import 'package:app_bangiay_doan/page/login-register/login_screen.dart';
import 'package:app_bangiay_doan/page/login-register/register_screen.dart';
import 'package:app_bangiay_doan/provider/favoriteprovider.dart';
import 'package:flutter/material.dart';
import 'package:app_bangiay_doan/page/splash/splashscreen.dart';
import 'package:app_bangiay_doan/page/splash/horizontalscrool.dart';
import 'package:app_bangiay_doan/page/Cart/paymentss.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoriteProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
      routes: {
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/horizontalScroll': (context) =>
            HorizontalScroll(), 
        '/main': (context) => MainPage(),
      },
    );
  }
}
