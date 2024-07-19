import 'package:flutter/material.dart';
import 'thongbao.dart';

class PayWidget extends StatefulWidget {
  const PayWidget({Key? key}) : super(key: key);

  @override
  _PayWidgetState createState() => _PayWidgetState();
}

class _PayWidgetState extends State<PayWidget> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh toán'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thanh Toán',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/hinh122.png',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text(
                              'Size: 10',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Text(
                              'Số lượng: 1',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nike Air Force 1 Shadow',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '3.829.000₫',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Divider(thickness: 1, color: Colors.grey),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng tiền',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '4.032.829₫',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Phương thức thanh toán:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Column(
                children: [
                  ListTile(
                    leading: Radio<String>(
                      value: 'MoMo',
                      groupValue: _selectedPaymentMethod,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedPaymentMethod = value;
                        });
                      },
                    ),
                    title: Text('Thanh toán bằng MoMo'),
                    trailing: Image.asset(
                      'assets/images/MoMo_Logo.png',
                      width: 32,
                      height: 32,
                    ),
                  ),
                  ListTile(
                    leading: Radio<String>(
                      value: 'Cash',
                      groupValue: _selectedPaymentMethod,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedPaymentMethod = value;
                        });
                      },
                    ),
                    title: Text('Thanh toán bằng tiền mặt'),
                    trailing: Image.asset(
                      'assets/images/tm22.png',
                      width: 32,
                      height: 32,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedPaymentMethod != null) {
                      // Điều hướng đến trang thông báo thành công
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentSuccessScreen()),
                      );
                    } else {
                      // Hiển thị thông báo khi chưa chọn phương thức thanh toán
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Vui lòng chọn phương thức thanh toán')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text('Xác nhận thanh toán', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
