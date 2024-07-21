import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  final Set<int> _favoriteProductIds = {};

  Set<int> get favoriteProductIds => _favoriteProductIds;

  void toggleFavorite(int productId) {
    if (_favoriteProductIds.contains(productId)) {
      _favoriteProductIds.remove(productId);
    } else {
      _favoriteProductIds.add(productId);
    }
    notifyListeners();
  }

  int get favoriteCount => _favoriteProductIds.length;
}
