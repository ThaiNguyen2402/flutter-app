import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  register() {
    // Regular expressions for validation
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
    final phoneRegExp = RegExp(r'^\d{10,11}$');
    final dobRegExp = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    final passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[!@#\$%^&*]).{6,}$');

    // Email validation
    if (!emailRegExp.hasMatch(emailController.text)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Thông báo'),
          content: Text('Email bắt buộc phải là @gmail.com'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } 
    // Phone number validation
    else if (!phoneRegExp.hasMatch(phoneController.text)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Thông báo'),
          content: Text('Số điện thoại phải từ 10 - 11 số'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } 
    // Date of birth validation
    else if (!dobRegExp.hasMatch(dobController.text)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Thông báo'),
          content: Text('Ngày sinh có định dạng dd/mm/yyyy'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } 
    // Password validation
    else if (!passwordRegExp.hasMatch(passwordController.text)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Thông báo'),
          content: Text(
            'Mật khẩu phải bắt đầu bằng chữ in hoa và chứa ít nhất 1 ký tự đặc biệt.\nVí dụ: Password@1',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } 
    // Check for empty fields and password match
    else if (nameController.text.isEmpty ||
             usernameController.text.isEmpty ||
             addressController.text.isEmpty ||
             phoneController.text.isEmpty ||
             passwordController.text.isEmpty ||
             confirmPasswordController.text.isEmpty ||
             emailController.text.isEmpty ||
             dobController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Thông báo'),
          content: Text('Vui lòng nhập đầy đủ thông tin'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else if (passwordController.text != confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Thông báo'),
          content: Text('Mật khẩu không khớp'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Registration logic here
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Thông báo'),
          content: Text('Đăng ký thành công'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
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
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Spacer(),
                ],
              ),
              Image.asset(
                'assets/images/Logo1.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 40),
              Text(
                'Đăng Ký Tài Khoản !',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Họ và tên',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 5),
              requiredField(),
              SizedBox(height: 15),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Tên tài khoản',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 5),
              requiredField(),
              SizedBox(height: 15),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 5),
              requiredField(),
              SizedBox(height: 15),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Địa chỉ',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 5),
              requiredField(),
              SizedBox(height: 15),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Số điện thoại',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 5),
              requiredField(),
              SizedBox(height: 15),
              TextField(
                controller: dobController,
                decoration: InputDecoration(
                  labelText: 'Ngày sinh',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 5),
              requiredField(),
              SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
              SizedBox(height: 5),
              requiredField(),
              SizedBox(height: 15),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Nhập lại mật khẩu',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
              SizedBox(height: 5),
              requiredField(),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
                child: Text(
                  'Đăng Ký',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget requiredField() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '* Bắt buộc',
        style: TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }
}
