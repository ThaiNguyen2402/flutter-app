import 'package:flutter/material.dart';
import '../homewidget.dart';

class UpdateProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Cập nhật thông tin cá nhân'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Xong',
              style: TextStyle(color: const Color.fromARGB(255, 7, 4, 4)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.camera_alt,
                  size: 50,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  // Handle choosing a new profile picture
                },
                child: Text(
                  'Chọn ảnh',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              buildTextField('Họ và Tên:'),
              buildTextField('Email:'),
              buildTextField('Địa chỉ:'),
              buildTextField('Số điện thoại:'),
              buildTextField('Ngày sinh:'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
