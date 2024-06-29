import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/model/categorymodel.dart';
import '../../config/const.dart';
import '../../provider/categoryprovider.dart';
import '../product/productwidget.dart';
class CategoryListView extends StatelessWidget {
  final List<Category> categories;
  final List<String> categoryNames;

  const CategoryListView({super.key, required this.categories, required this.categoryNames});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.asMap().entries.map((entry) {
          int idx = entry.key;
          Category itemcate = entry.value;
          return itemCateView(itemcate, categoryNames[idx], context);
        }).toList(),
      ),
    );
  }
}

Widget itemCateView(Category itemcate, String categoryName, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductWidget(
            objCat: itemcate,
          ),
        ),
      );
    },
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.symmetric(horizontal: 4), // Thay đổi margin để căn giữa các mục
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)), // Bo tròn góc của hình vuông
          ),
          child: Container(
            width: 150, // Kích thước chiều rộng của hình vuông
            height: 150, // Kích thước chiều cao của hình vuông
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: itemcate.img != null // Kiểm tra giá trị của img
                ? Image.asset(
                    urlimg + itemcate.img!,
                    fit: BoxFit.cover,
                  )
                : Center(child: Text('No Image')), // Hiển thị thông báo khi img là null
          ),
        ),
        SizedBox(height: 8), // Khoảng cách giữa hình ảnh và văn bản
        Text(
          categoryName,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class Product {
  final String imageUrl;
  final String name;
  final double price;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
  });
}
class _HomePageState extends State<HomePage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  late Future<List<Category>> futureCategories;
  final NumberFormat priceFormat = NumberFormat("#,###.###đ");

  final List<String> categoryNames = [
    'Air Force',
    'Air Max',
    'SB Dunk',
    'Air Jordan 1',
  ];

  // Danh sách sản phẩm cần hiển thị
  final List<Product> products = [
    Product(imageUrl: 'assets/images/products/af1.png', name: 'Nike Air Force 1', price: 3000000),
    Product(imageUrl: 'assets/images/products/am1.png', name: 'Nike Air Max 1', price: 5000000),
    Product(imageUrl: 'assets/images/products/dunk1.png', name: 'Nike SB Dunk', price: 4000000),
    Product(imageUrl: 'assets/images/products/jd1.png', name: 'Nike Air Jordan 1', price: 5500000),
  ];

  // Danh sách trạng thái yêu thích của sản phẩm (ban đầu tất cả là false)
  List<bool> isFavorite = List.generate(4, (_) => false);

  @override
  void initState() {
    super.initState();
    futureCategories = loadCateList();
  }

  Future<List<Category>> loadCateList() async {
    List<Category> categories = await ReadData().loadData();
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/images/banner1.png',
      'assets/images/banner2.png',
      'assets/images/banner3.png',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/Logo1.png',
          fit: BoxFit.contain,
          height: 60,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.search,
              size: 32,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CarouselSlider(
              items: imgList.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.amber,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          item,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              carouselController: _controller,
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Dành cho bạn',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            FutureBuilder<List<Category>>(
              future: futureCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No categories found');
                } else {
                  return CategoryListView(
                    categories: snapshot.data!,
                    categoryNames: categoryNames,
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sản phẩm nổi bật',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Thêm xử lý khi nhấn vào nút "Tất cả" ở đây
                    },
                    child: Text(
                      'Tất cả',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                height: 300, // Độ cao của danh sách sản phẩm
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length, // Số lượng sản phẩm cần hiển thị
                  itemBuilder: (BuildContext context, int index) {
                    // Lấy sản phẩm từ danh sách
                    Product product = products[index];

                    // Lấy trạng thái yêu thích của sản phẩm
                    bool isFavorited = isFavorite[index];

                    // Sử dụng switch case để xác định hình ảnh và tên sản phẩm dựa trên index
                    String imageUrl = '';
                    String productName = '';
                    switch (index) {
                      case 0:
                        imageUrl = 'assets/images/products/af1.png';
                        productName = 'Nike Air Force 1';
                        break;
                      case 1:
                        imageUrl = 'assets/images/products/am1.png';
                        productName = 'Nike Air Max 1';
                        break;
                      case 2:
                        imageUrl = 'assets/images/products/dunk1.png';
                        productName = 'Nike SB Dunk';
                        break;
                      case 3:
                        imageUrl = 'assets/images/products/jd1.png';
                        productName = 'Nike Air Jordan 1';
                        break;
                      default:
                        imageUrl = '';
                        productName = '';
                        break;
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150, // Độ rộng của hình ảnh sản phẩm
                            height: 150, // Độ cao của hình ảnh sản phẩm
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black, width: 1.5), // Đặt viền màu đen
                            ),
                            // Hiển thị hình ảnh sản phẩm
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            productName, // Hiển thị tên của sản phẩm
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            priceFormat.format(product.price), // Hiển thị giá tiền của sản phẩm
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Xử lý khi nhấn vào nút "Mua ngay"
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black, // Màu nút là màu xanh
                                ),
                                child: Text(
                                  'Mua ngay',
                                  style: TextStyle(
                                    color: Colors.white, // Màu chữ là màu trắng
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Đảo ngược trạng thái yêu thích của sản phẩm khi nhấn vào biểu tượng trái tim
                                  setState(() {
                                    isFavorite[index] = !isFavorite[index];
                                  });
                                },
                                icon: Icon(
                                  isFavorited ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.black, // Màu biểu tượng là màu đỏ
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
