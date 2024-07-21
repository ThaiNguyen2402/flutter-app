import 'package:app_bangiay_doan/page/trangchu/carouselwidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_bangiay_doan/data/data/api.dart';
import 'package:app_bangiay_doan/data/data/sqlite.dart';
import 'package:app_bangiay_doan/data/models/cart.dart';
import 'package:app_bangiay_doan/data/models/category.dart';
import 'package:app_bangiay_doan/data/models/product.dart';
import 'package:app_bangiay_doan/page/trangchu/product_detail.dart';

// Create the formatCurrency function
String formatCurrency(double amount) {
  final NumberFormat formatter = NumberFormat('#,###.###', 'vi_VN');
  return '${formatter.format(amount)} đ';
}

class HomeBuilder extends StatefulWidget {
  const HomeBuilder({Key? key}) : super(key: key);

  @override
  State<HomeBuilder> createState() => _HomeBuilderState();
}

class _HomeBuilderState extends State<HomeBuilder> {
  final DatabaseHelper _databaseService = DatabaseHelper();
  late Set<int> favoriteProductIds;
  late List<ProductModel> allProducts;
  late Future<List<ProductModel>> _productsFuture;
  late Future<List<CategoryModel>> _categoriesFuture;
  CategoryModel? selectedCategory;
  bool showAllProducts = false; // State to toggle between showing 4 or all products

  @override
  void initState() {
    super.initState();
    favoriteProductIds = Set<int>();
    allProducts = [];
    selectedCategory = null;
    _categoriesFuture = _getCategories();
    _productsFuture = _getProducts();
  }

  Future<List<ProductModel>> _getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await APIRepository().getProduct(
        prefs.getString('accountID').toString(),
        prefs.getString('token').toString());
  }

  Future<List<CategoryModel>> _getCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await APIRepository().getCategory(
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
    if (favoriteProductIds.contains(productId)) {
      favoriteProductIds.remove(productId);
    } else {
      favoriteProductIds.add(productId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã thêm vào yêu thích'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  });
}


  void _selectCategory(CategoryModel category) {
    setState(() {
      selectedCategory = selectedCategory == category ? null : category;
    });
  }

  void _toggleProductView() {
    setState(() {
      showAllProducts = !showAllProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: _categoriesFuture,
      builder: (context, categorySnapshot) {
        if (categorySnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return FutureBuilder<List<ProductModel>>(
          future: _productsFuture,
          builder: (context, productSnapshot) {
            if (productSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            List<ProductModel> filteredProducts = productSnapshot.data!;
            if (selectedCategory != null) {
              filteredProducts = filteredProducts.where((product) =>
                  product.categoryId == selectedCategory!.id).toList();
            }

            List<ProductModel> displayedProducts = showAllProducts
                ? filteredProducts
                : filteredProducts.take(4).toList();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    CarouselWidget(), // Use the new CarouselWidget here
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                      child: Text(
                        "Xin chào, bạn đã trở lại Fein Store!",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Dành cho bạn",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 180.0,
                      child: CategoryList(
                        categories: categorySnapshot.data!,
                        onSelectCategory: _selectCategory,
                        selectedCategory: selectedCategory,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Text(
                          "Sản phẩm nổi bật",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: _toggleProductView,
                          child: Text(showAllProducts ? 'Thu gọn' : 'Tất cả sản phẩm'),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    ProductGrid(
                      products: displayedProducts,
                      favoriteProductIds: favoriteProductIds,
                      onToggleFavorite: _toggleFavorite,
                      onSave: _onSave,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}


class CategoryList extends StatelessWidget {
  final List<CategoryModel> categories;
  final Function(CategoryModel) onSelectCategory;
  final CategoryModel? selectedCategory;

  const CategoryList({
    Key? key,
    required this.categories,
    required this.onSelectCategory,
    this.selectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            onSelectCategory(category);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  width: 120,
                  height: 120,
                  child: ClipOval(
                    child: Image.network(
                      category.imageUrl,
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: selectedCategory == category ? Colors.black : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProductGrid extends StatelessWidget {
  final List<ProductModel> products;
  final Set<int> favoriteProductIds;
  final Function(int) onToggleFavorite;
  final Function(ProductModel) onSave;

  const ProductGrid({
    Key? key,
    required this.products,
    required this.favoriteProductIds,
    required this.onToggleFavorite,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final itemProduct = products[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  product: itemProduct,
                ),
              ),
            );
          },
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Colors.black, width: 1.0), // Stroke border
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                    child: Image.network(
                      itemProduct.imageUrl,
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
                        itemProduct.name,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        NumberFormat('#,###.###đ').format(itemProduct.price),
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
                        icon: Icon(
                          favoriteProductIds.contains(itemProduct.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          onToggleFavorite(itemProduct.id);
                        },
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () => onSave(itemProduct),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.black,
                          minimumSize: Size(100, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Text('Mua ngay'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
