import 'package:flutter/material.dart';
import 'paywidget.dart'; // Import the PayWidget

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ Hàng'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product section
              Row(
                children: [
                  // Image
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/hinh122.png',
                          width: 145,
                          height: 205,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  // Product details
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Size: 18', textAlign: TextAlign.right),
                          SizedBox(height: 8.0),
                          Text('Số lượng: 1', textAlign: TextAlign.right),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Nike Air Force 1 Shadow',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '3.829.000₫',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Divider(thickness: 1), // Đường kẻ ngăn cách
              SizedBox(height: 16.0),
              // Cart summary
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tiền giày', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                      Text('3.829.000₫', style: TextStyle(fontSize: 20.0)),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Vận chuyển', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                      Text('200.000₫', style: TextStyle(fontSize: 20.0)),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Thuế VAT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                      Text('38.290₫', style: TextStyle(fontSize: 20.0)),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Divider(thickness: 1), // Đường kẻ ngăn cách tổng tiền
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng tiền', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                      Text('4.032.829₫', style: TextStyle(fontSize: 20.0)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              // Checkout button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PayWidget()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Màu nền
                    foregroundColor: Colors.white, // Màu chữ
                    padding: EdgeInsets.symmetric(horizontal: 64.0, vertical: 16.0),
                  ),
                  child: Text('Thanh toán', style: TextStyle(fontSize: 18.0)),
                ),
              ),
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}
