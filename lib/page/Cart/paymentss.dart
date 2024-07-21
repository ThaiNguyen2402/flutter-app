import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán thành công'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check_circle_outline, color: Colors.green, size: 100.0),
            SizedBox(height: 16.0),
            Text(
              'Thanh toán của bạn đã thành công!',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Cảm ơn bạn đã mua hàng!',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Quay lại trang trước đó
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, // Màu chữ
                backgroundColor: Colors.black, // Màu nền
                minimumSize: Size(100, 40), // Kích thước tối thiểu
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text('Quay lại giỏ hàng'),
            ),
          ],
        ),
      ),
    );
  }
}