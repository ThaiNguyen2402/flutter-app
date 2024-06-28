import 'package:flutter/material.dart';
import '../../data/model/productmodel.dart';
import '../../config/const.dart';
import 'package:intl/intl.dart';

Widget itemGridView(Product productModel) {
  return Container(
    margin: const EdgeInsets.all(4),
    // padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      border: Border.all(
        color: Colors.black,
        width: 1.5,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Image.asset(
            url_product_img + productModel.img!,
            height: 100,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image),
          ),
        ),
        Text(
          productModel.name ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          NumberFormat('#,###,###đ').format(productModel.price),
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
          selectionColor: const Color.fromARGB(255, 0, 0, 1),
        ),
      ],
    ),
  );
}
