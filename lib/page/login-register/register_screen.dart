import 'package:flutter/material.dart';
import 'package:app_bangiay_doan/data/data/api.dart';
import 'package:app_bangiay_doan/data/models/register.dart';
import 'package:app_bangiay_doan/page/login-register/login_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int _gender = 0;
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _numberIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _schoolKeyController = TextEditingController();
  final TextEditingController _schoolYearController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  String gendername = 'None';
  String temp = '';
  final _formKey = GlobalKey<FormState>();

  // State variables for password visibility
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Future<String> register() async {
    if (!_formKey.currentState!.validate()) {
      return 'Vui lòng điền đủ thông tin';
    }

    if (_gender == 0) {
      return 'Vui lòng chọn giới tính';
    }

    return await APIRepository().register(Signup(
        accountID: _accountController.text,
        birthDay: _birthDayController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        fullName: _fullNameController.text,
        phoneNumber: _phoneNumberController.text,
        schoolKey: _schoolKeyController.text,
        schoolYear: _schoolYearController.text,
        gender: getGender(),
        imageUrl: '',
        numberID: _numberIDController.text));
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email không được để trống';
    }
    final emailRegEx = RegExp(r'^[^@]+@gmail\.com$');
    if (!emailRegEx.hasMatch(value)) {
      return 'Email phải có dạng @gmail.com';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Số điện thoại không được để trống';
    }
    if (value.length < 10 || value.length > 11) {
      return 'Số điện thoại phải có từ 10 - 11 số';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu không được để trống';
    }
    final passwordRegEx = RegExp(r'^(?=.*[A-Z])(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (!passwordRegEx.hasMatch(value)) {
      return 'Mật khẩu phải có 1 chữ in hoa đầu và 1 ký tự đặc biệt (Ví dụ: Example@1)';
    }
    return null;
  }

  String? validateZipCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mã zip không được để trống';
    }
    if (value != '700000') {
      return 'Mã zip phải là 700000 (Ví dụ: 700000)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đăng nhập", style: TextStyle(fontSize: 16)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Logo1.png',
                    height: 80,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Vui lòng đăng ký tài khoản !",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  signUpWidget(),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            String response = await register();
                            if (response == "ok") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginScreen()));
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Lỗi'),
                                  content: Text(response),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                            minimumSize: Size(100, 40),
                          ),
                          child: const Text('Đăng ký'),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getGender() {
    if (_gender == 1) {
      return "Nam";
    } else if (_gender == 2) {
      return "Nữ";
    }
    return "Khác";
  }

  Widget textField(TextEditingController controller, String label, {bool obscureText = false, String? Function(String?)? validator, Widget? suffixIcon}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: suffixIcon,
        ),
        validator: validator,
      ),
    );
  }

  Widget signUpWidget() {
    return Column(
      children: [
        textField(_accountController, "Tên tài khoản", validator: (value) => value!.isEmpty ? 'Tên tài khoản không được để trống' : null),
        textField(_fullNameController, "Họ và tên", validator: (value) => value!.isEmpty ? 'Họ và tên không được để trống' : null),
        textField(_numberIDController, "Mã zip", validator: validateZipCode),
        textField(_phoneNumberController, "Số điện thoại", validator: validatePhoneNumber),
        textField(_birthDayController, "Ngày sinh (dd/mm/yyyy)", validator: (value) => value!.isEmpty ? 'Ngày sinh không được để trống' : null),
        textField(_schoolYearController, "Email", validator: validateEmail),
        textField(_schoolKeyController, "Địa chỉ", validator: (value) => value!.isEmpty ? 'Địa chỉ không được để trống' : null),
        textField(
          _passwordController,
          "Mật khẩu",
          obscureText: !_isPasswordVisible,
          validator: validatePassword,
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
        textField(
          _confirmPasswordController,
          "Xác nhận mật khẩu",
          obscureText: !_isConfirmPasswordVisible,
          validator: (value) => value != _passwordController.text ? 'Xác nhận mật khẩu không khớp' : null,
          suffixIcon: IconButton(
            icon: Icon(
              _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              });
            },
          ),
        ),
        const Text(
          "Giới tính ?",
          style: TextStyle(fontSize: 18),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text("Nam"),
                leading: Radio(
                  value: 1,
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text("Nữ"),
                leading: Radio(
                  value: 2,
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text("Khác"),
                leading: Radio(
                  value: 3,
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
