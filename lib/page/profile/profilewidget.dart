import 'dart:convert';
import 'package:app_bangiay_doan/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart'; // Import the settings page

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  User user = User.userEmpty();

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? strUser = pref.getString('user');

    if (strUser != null) {
      user = User.fromJson(jsonDecode(strUser));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // create style
    TextStyle labelStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    TextStyle valueStyle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: user.imageURL != null && user.imageURL!.isNotEmpty
                        ? Image.network(
                            user.imageURL!,
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            Icons.person,
                            size: 200,
                            color: Colors.grey,
                          ),
                  ),
                  const SizedBox(height: 8.0),
                  Text.rich(
                    TextSpan(
                      text: "Họ và tên: ",
                      style: labelStyle,
                      children: [
                        TextSpan(
                          text: user.fullName,
                          style: valueStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text.rich(
                    TextSpan(
                      text: "Địa chỉ: ",
                      style: labelStyle,
                      children: [
                        TextSpan(
                          text: user.schoolKey,
                          style: valueStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text.rich(
                    TextSpan(
                      text: "Email: ",
                      style: labelStyle,
                      children: [
                        TextSpan(
                          text: user.schoolYear,
                          style: valueStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text.rich(
                    TextSpan(
                      text: "Ngày sinh: ",
                      style: labelStyle,
                      children: [
                        TextSpan(
                          text: user.birthDay,
                          style: valueStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text.rich(
                    TextSpan(
                      text: "Số điện thoại: ",
                      style: labelStyle,
                      children: [
                        TextSpan(
                          text: user.phoneNumber,
                          style: valueStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const SizedBox(height: 40),
                  OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Thông báo'),
                            content: const Text('Chức năng đang phát triển'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Chỉnh Sửa',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
