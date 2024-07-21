import 'package:app_bangiay_doan/data/data/api.dart';
import 'package:flutter/material.dart';
import 'package:app_bangiay_doan/page/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_bangiay_doan/data/data/sharepre.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  login() async {
    if (accountController.text.isEmpty || passwordController.text.isEmpty) {
      // Show a dialog if the fields are empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Thông báo'),
          content: Text('Vui lòng điền đầy đủ thông tin'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      try {
        // Get token (save to SharedPreferences)
        String token = await APIRepository()
            .login(accountController.text, passwordController.text);
        var user = await APIRepository().current(token);
        // Save user
        saveUser(user);
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đăng nhập thành công'),
          ),
        );
        // Navigate to MainPage
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
        return token;
      } catch (e) {
        // Show error message if login fails
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Lỗi'),
            content: Text('Đăng nhập thất bại. Vui lòng thử lại.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    //autoLogin();
  }

  autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Logo1.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 20),
              Text(
                'Xin Chào !',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Vui Lòng Đăng Nhập.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 30),
              TextField(
                controller: accountController,
                decoration: InputDecoration(
                  labelText: 'Tài khoản',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Quên mật khẩu ?',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Người mới ? Tạo tài khoản'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
