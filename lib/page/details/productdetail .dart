import 'package:flutter/material.dart';

import '../trangchu/trangchuwidget.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin sản phẩm'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  widget.product.imageUrl, // Sử dụng hình ảnh sản phẩm thực tế
                  height: 250,
                ),
              ),
              SizedBox(height: 16),
              Text(
                widget.product.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '${widget.product.price}đ',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Từ niềm đam mê với môn thể thao chạy bộ và nhận ra được nhu cầu ngày càng tăng đối với giày chạy, Bill Bowerman và học trò Phil Knight đã thành lập Blue Ribbon Sport (BRS) vào năm 1964, hoạt động với vai trò phân phối giày thương hiệu Onizuka đến từ Nhật. Phải đến năm 1971, khi mối quan hệ với nhà cung cấp Nhật có sự rạn nứt, điều này đã thúc đẩy Bill cho ra đời thương hiệu Nike với những đôi giày do hãng tự thiết kế và sản xuất.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Chọn size giày',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [10, 11, 12].map((size) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ChoiceChip(
                      label: Text(size.toString()),
                      selected: false,
                      onSelected: (bool selected) {
                        // Handle size selection
                      },
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      // Handle decrease quantity
                    },
                  ),
                  Text(
                    '1',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // Handle increase quantity
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle add to favorites
                      },
                      child: Text('Yêu thích sản phẩm'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle buy now
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'Mua ngay',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}