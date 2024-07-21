import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_bangiay_doan/page/login-register/login_screen.dart';
import 'package:app_bangiay_doan/data/data/sharepre.dart'; 

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = false;
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Tải các cài đặt đã lưu
  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications') ?? false;
      _selectedLanguage = prefs.getString('language') ?? 'English';
    });
  }

  // Lưu các cài đặt
  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notifications', _notificationsEnabled);
    prefs.setString('language', _selectedLanguage);
  }

  // Hàm đăng xuất
  Future<void> _logOut() async {
    bool success = await logOut(context); // Gọi hàm logOut có sẵn
    if (success) {
      // Xử lý các hành động sau khi đăng xuất nếu cần
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tài khoản',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.security, color: Colors.black),
              title: const Text('Đổi mật khẩu'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Hiển thị thông báo thay vì điều hướng
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thông báo'),
                      content: const Text('Chức năng đang được triển khai'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 30),
            const Text(
              'Ứng dụng',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.black),
              title: const Text('Thông báo'),
              trailing: Switch(
                value: _notificationsEnabled,
                activeColor: Colors.black, // Màu khi công tắc bật
                inactiveTrackColor: Colors.grey, // Màu của thanh khi công tắc tắt
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                    _saveSettings();
                  });
                },
              ),
              onTap: () {
                // Hiển thị hộp thoại để chuyển đổi thông báo
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thông báo'),
                      content: Text(_notificationsEnabled
                          ? 'Thông báo hiện đang bật'
                          : 'Thông báo hiện đang tắt'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.black),
              title: const Text('Ngôn ngữ'),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                items: const [
                  DropdownMenuItem(value: 'Vietnamese', child: Text('Tiếng Việt')),
                  DropdownMenuItem(value: 'English', child: Text('Tiếng Anh')),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                    _saveSettings();
                  });
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.black),
              title: const Text('Thông tin ứng dụng'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Hiển thị hộp thoại thông tin ứng dụng
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thông tin ứng dụng'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Nhóm:'),
                          const SizedBox(height: 10),
                          const Text('Thành viên:'),
                          const Text('1'),
                          const Text('2'),
                          const Text('3'),
                          const Text('4'),
                          const Text('5'),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 30),
            const Spacer(),
            Center(
              child: OutlinedButton(
                onPressed: _logOut,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Đăng xuất'),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
