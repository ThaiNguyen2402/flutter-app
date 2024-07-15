import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../trangchu/trangchuwidget.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isFavorited = false;
  int? selectedSizeIndex;
  int quantity = 1;
  bool isExpanded =
      false; // Biến để kiểm soát trạng thái mô tả đã mở rộng hay chưa

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    isExpanded = false; // Ban đầu mô tả sản phẩm được thu gọn
  }

  @override
  Widget build(BuildContext context) {
    // Định dạng giá tiền
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin sản phẩm'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorited = !isFavorited;
              });
            },
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: Colors.black,
            ),
          ),
        ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isFavorited = !isFavorited;
                      });
                    },
                    icon: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                currencyFormat.format(widget.product.price),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16),
              AnimatedCrossFade(
                duration: Duration(milliseconds: 300),
                crossFadeState: isExpanded
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: Text(
                  'Từ niềm đam mê với môn thể thao chạy bộ và nhận ra được nhu cầu ngày càng tăng đối với giày chạy, Bill Bowerman và học trò Phil Knight đã thành lập Blue Ribbon Sport (BRS) vào năm 1964, hoạt động với vai trò phân phối giày thương hiệu Onizuka đến từ Nhật. Phải đến năm 1971, khi mối quan hệ với nhà cung cấp Nhật có sự rạn nứt, điều này đã thúc đẩy Bill cho ra đời thương hiệu Nike với những đôi giày do hãng tự thiết kế và sản xuất.',
                  style: TextStyle(fontSize: 16),
                ),
                secondChild: Text(
                  'Từ niềm đam mê với môn thể thao chạy bộ và nhận ra được nhu cầu ngày càng tăng đối với giày chạy, Bill Bowerman và học trò Phil Knight đã thành lập Blue Ribbon Sport (BRS) vào năm 1964, hoạt động với vai trò phân phối giày thương hiệu Onizuka đến từ Nhật. Phải đến năm 1971, khi mối quan hệ với nhà cung cấp Nhật có sự rạn nứt, điều này đã thúc đẩy Bill cho ra đời thương hiệu Nike với những đôi giày do hãng tự thiết kế và sản xuất.',
                  style: TextStyle(fontSize: 16),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? 'Thu gọn' : 'Xem thêm',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chọn size giày',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [10, 11, 12].asMap().entries.map((entry) {
                          int index = entry.key;
                          int size = entry.value;
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSizeIndex = index;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedSizeIndex == index
                                      ? Colors.black
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: Text(
                                  size.toString(),
                                  style: TextStyle(
                                    color: selectedSizeIndex == index
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Spacer(), // Để tạo khoảng cách giữa cột "Chọn size giày" và cột "Số lượng"
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: decreaseQuantity,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            quantity.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: increaseQuantity,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle buy now
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32), // Đổi kích thước nút "Mua ngay"
                  ),
                  child: Text(
                    'Mua ngay',
                    style: TextStyle(
                      fontSize: 20,
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
