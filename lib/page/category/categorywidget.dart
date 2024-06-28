import 'package:flutter/material.dart';
import '../../data/model/categorymodel.dart';
import '../../provider/categoryprovider.dart';
import 'categorybody.dart';
import '../../config/const.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Category> lsCate = [];
  Future<String> loadCateList() async {
    lsCate = await ReadData().loadData();
    return '';
  }

  @override
  void initState() {
    //ToDo : implement initState
    super.initState();
    loadCateList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadCateList(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Center(
            child: Column(
              children: [
                const Text(
                  "Category list",
                  style: titleStyle,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: lsCate.length,
                        itemBuilder: (context, index) {
                          return itemCateView(lsCate[index], context);
                        }))
              ],
            ),
          );
        });
  }
}
