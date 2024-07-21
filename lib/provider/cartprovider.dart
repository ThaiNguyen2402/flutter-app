import 'package:flutter/material.dart';
import 'package:app_bangiay_doan/data/models/cart.dart';
import 'package:app_bangiay_doan/data/data/sqlite.dart';

class CartProvider with ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Cart> _products = [];

  List<Cart> get products => _products;

  int get productCount => _products.length;

  Future<void> fetchProducts() async {
    _products = await _databaseHelper.products();
    notifyListeners();
  }

  Future<void> addProduct(Cart product) async {
    await _databaseHelper.add(product);
    await fetchProducts();
  }

  Future<void> removeProduct(String productId) async {
    await _databaseHelper.deleteProduct(productId as int);
    await fetchProducts();
  }

  Future<void> clearCart() async {
    await _databaseHelper.clear();
    await fetchProducts();
  }
}
