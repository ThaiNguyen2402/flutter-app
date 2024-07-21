import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_bangiay_doan/data/data/api.dart';
import 'package:app_bangiay_doan/data/data/sqlite.dart';
import 'package:app_bangiay_doan/data/models/cart.dart';
import 'package:app_bangiay_doan/data/models/product.dart';

// Create the formatCurrency function
String formatCurrency(double amount) {
  final NumberFormat formatter = NumberFormat('#,###.###', 'vi_VN');
  return '${formatter.format(amount)} đ';
}

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final DatabaseHelper _databaseService = DatabaseHelper();
  late Set<int> favoriteProductIds;
  late Future<List<ProductModel>> _productsFuture;
  bool _showProduct = true;

  @override
  void initState() {
    super.initState();
    favoriteProductIds = Set<int>();
    _productsFuture = _getProducts();
  }

  Future<List<ProductModel>> _getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await APIRepository().getProduct(
        prefs.getString('accountID').toString(),
        prefs.getString('token').toString());
  }

  Future<void> _onSave(ProductModel pro) async {
    _databaseService.insertProduct(Cart(
        productID: pro.id,
        name: pro.name,
        des: pro.description,
        price: pro.price,
        img: pro.imageUrl,
        count: 1));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã thêm sản phẩm vào giỏ hàng'),
        duration: Duration(seconds: 1),
      ),
    );
    setState(() {});
  }

  void _toggleFavorite(int productId) {
    setState(() {
      _showProduct = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sản phẩm đã xóa khỏi yêu thích'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _reloadPage() {
    setState(() {
      _showProduct = true;
      _productsFuture = _getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: _productsFuture,
      builder: (context, productSnapshot) {
        if (productSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (productSnapshot.data!.isEmpty || !_showProduct) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Sản phẩm yêu thích"),
              actions: [
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: _reloadPage,
                ),
              ],
            ),
            body: Center(
              child: Text("Không có sản phẩm yêu thích nào."),
            ),
          );
        }

        List<ProductModel> products = productSnapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Sản phẩm yêu thích"),
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _reloadPage,
              ),
            ],
          ),
          body: _showProduct
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: 1, // Chỉ hiển thị một sản phẩm
                    itemBuilder: (context, index) {
                      ProductModel product = products[0]; // Chỉ lấy sản phẩm đầu tiên
                      return Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(color: Colors.black, width: 1.0), // Stroke border
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
                                child: Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    NumberFormat('#,###.###đ').format(product.price),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      _toggleFavorite(product.id);
                                    },
                                  ),
                                  const Spacer(),
                                  ElevatedButton(
                                    onPressed: () => _onSave(product),
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white, backgroundColor: Colors.black,
                                      minimumSize: const Size(100, 40),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    child: const Text('Mua ngay'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: Text("Không có sản phẩm yêu thích nào."),
                ),
        );
      },
    );
  }
}
