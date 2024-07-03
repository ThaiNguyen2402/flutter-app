import 'package:flutter/material.dart';
import 'profileedit.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Thông tin cá nhân',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
      )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
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
                    SizedBox(height: 50),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateProfileScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Chỉnh Sửa',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Column(
                  children: [
                    buildInfoRow(
                      'Họ và Tên:',
                      'Nguyễn Trần Quang Thái',
                    ),
                    buildInfoRow('Email:', 'email@gmail.com'),
                    buildInfoRow('Địa chỉ:', '600 Sư Vạn Hạnh, P1, Q10'),
                    buildInfoRow('Số điện thoại:', '0903933765'),
                    buildInfoRow('Ngày sinh:', '21/01/2000'),
                  ],
                ),
              ),
              SizedBox(height: 50),
              OutlinedButton(
                onPressed: () {},
                child: Text(
                  'Đăng xuất',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(content),
          ),
        ],
      ),
    );
  }
}
