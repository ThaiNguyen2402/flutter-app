import '../../data/model/categorymodel.dart';
import 'package:flutter/material.dart';
import '../../data/model/productmodel.dart';
import '../../provider/productprovider.dart';
import 'productbody.dart';
import '../../config/const.dart';

class ProductWidget extends StatefulWidget {
  final Category objCat;
  const ProductWidget({super.key, required this.objCat});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  List<Product> lstProduct = [];

  Future<String> loadProdList(int cartId) async {
    lstProduct = await ReadData().loadDataByCat(cartId) as List<Product>;
    return '';
  }

  @override
  void initState() {
    super.initState();
    loadProdList(widget.objCat.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('${widget.objCat.name.toString().toUpperCase()}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: loadProdList(widget.objCat.id!),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return GridView.builder(
                  itemCount: lstProduct.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    return itemGridView(lstProduct[index]);
                  });
            }),
      ),
    );
  }
}
