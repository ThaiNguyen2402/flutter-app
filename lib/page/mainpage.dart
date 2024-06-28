import 'package:app_bangiay_doan/page/trangchu/trangchubody.dart';
import 'package:app_bangiay_doan/page/trangchu/trangchuwidget.dart';
import 'package:flutter/material.dart';
import '../page/homewidget.dart';
import 'category/categorywidget.dart';
import 'history/historywidget.dart';
import 'favorite/favoritewidget.dart';
import '../page/product/productcart.dart';
import '../page/product/productlist.dart';
import 'profile/profilewidget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex  = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CategoryWidget(),
    ProductList(),
    ProductCart(),
    FavoriteWidget(),
    HistoryWidget(),
    ProfileWidget(),
  ];
   
   void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
   }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_add_outlined),
              label: 'Đơn hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Yêu thích',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Giỏ hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline_rounded),
              label: 'Cá nhân',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}