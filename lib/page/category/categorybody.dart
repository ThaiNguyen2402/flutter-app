import 'package:flutter/material.dart';
import '../../data/model/categorymodel.dart';
import '../../config/const.dart';
import '../product/productwidget.dart';

class CategoryListView extends StatelessWidget {
  final List<Category> categories;

  const CategoryListView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical, // Cuộn ngang
      child: Row(
        children: categories.map((itemcate) => itemCateView(itemcate, context)).toList(),
      ),
    );
  }
}

Widget itemCateView(Category itemcate, BuildContext context) {
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
    child: Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 10), // Thay đổi margin để căn giữa các mục
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)), // Bo tròn góc của hình vuông
      ),
      child: Container(
        width: 120, // Kích thước chiều rộng của hình vuông
        height: 120, // Kích thước chiều cao của hình vuông
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Image.asset(
          urlimg + itemcate.img!,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
