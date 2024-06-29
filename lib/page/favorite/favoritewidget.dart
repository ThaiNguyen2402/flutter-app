import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Tạo class Product mới trong FavoriteWidget
class FavoriteProduct {
  final String imageUrl;
  final String name;
  final double price;

  FavoriteProduct({
    required this.imageUrl,
    required this.name,
    required this.price,
  });
}

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  final NumberFormat priceFormat = NumberFormat("#,###.###đ");

  // Danh sách sản phẩm yêu thích cứng
  final List<FavoriteProduct> favoriteProducts = List.generate(4, (index) {
    switch (index) {
      case 0:
        return FavoriteProduct(imageUrl: 'assets/images/products/af1.png', name: 'Nike Air Force 1', price: 3000000);
      case 1:
        return FavoriteProduct(imageUrl: 'assets/images/products/am1.png', name: 'Nike Air Max 1', price: 5000000);
      case 2:
        return FavoriteProduct(imageUrl: 'assets/images/products/dunk1.png', name: 'Nike SB Dunk', price: 4000000);
      case 3:
        return FavoriteProduct(imageUrl: 'assets/images/products/jd1.png', name: 'Nike Air Jordan 1', price: 5500000);
      default:
        return FavoriteProduct(imageUrl: '', name: '', price: 0);
    }
  });

  // Danh sách trạng thái yêu thích của sản phẩm (ban đầu tất cả là false)
  List<bool> isFavorite = List.generate(4, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/Logo1.png',
          fit: BoxFit.contain,
          height: 60,
        ),
        centerTitle: true, // Centers the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sản phẩm yêu thích',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];
                  bool isFavorited = isFavorite[index];
                  return Column(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black, width: 1.5), // Đặt viền màu đen
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            product.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        priceFormat.format(product.price),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Đưa các thành phần về giữa
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý khi nhấn vào nút "Mua ngay"
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black, // Màu nút là màu đen
                            ),
                            child: Text(
                              'Mua ngay',
                              style: TextStyle(
                                color: Colors.white, // Màu chữ là màu trắng
                              ),
                            ),
                          ),
                          const SizedBox(width: 8), // Khoảng cách giữa nút và biểu tượng
                          IconButton(
                            onPressed: () {
                              // Đảo ngược trạng thái yêu thích của sản phẩm khi nhấn vào biểu tượng trái tim
                              setState(() {
                                isFavorite[index] = !isFavorite[index];
                              });
                            },
                            icon: Icon(
                              isFavorited ? Icons.favorite_border : Icons.favorite,
                              color: Colors.black, 
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
