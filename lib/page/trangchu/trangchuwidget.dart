import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
            width: 140, // Kích thước chiều rộng của hình vuông
            height: 140, // Kích thước chiều cao của hình vuông
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
            fontSize: 16,
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

class _HomePageState extends State<HomePage> {
  int _current = 0; // Biến để lưu trạng thái trang hiện tại của slider
  final CarouselController _controller = CarouselController();
  late Future<List<Category>> futureCategories;

  final List<String> categoryNames = [
    'Air Force',
    'Air Max',
    'SB Dunk',
    'Air Jordan 1',
  ];

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
        title: Text(
          'Fein Store',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.search,
              size: 32, // Tăng kích thước của icon tìm kiếm
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
                        borderRadius: BorderRadius.circular(15), // Bo tròn góc của slider
                        color: Colors.amber,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15), // Bo tròn góc của hình ảnh
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
                height: 180, // Giảm chiều cao của slider
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
                  'Dành Cho Bạn',
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
          ],
        ),
      ),
    );
  }
}
