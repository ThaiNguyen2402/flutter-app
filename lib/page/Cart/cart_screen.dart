import 'package:app_bangiay_doan/data/data/sqlite.dart';
import 'package:app_bangiay_doan/page/Cart/paymentss.dart';
import 'package:app_bangiay_doan/data/data/api.dart';
import 'package:app_bangiay_doan/data/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  String? _selectedSize; // Variable to store the selected size

  Future<List<Cart>> _getProducts() async {
    return await _databaseHelper.products();
  }

  void _showPaymentDialog() async {
    List<Cart> products = await _getProducts();

    if (products.isEmpty) {
      // Show a message if the cart is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không có sản phẩm để thanh toán')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PaymentDialog(
          onConfirm: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            await APIRepository().addBill(products, pref.getString('token').toString());
            _databaseHelper.clear();

            Navigator.of(context).pop(); // Close dialog before navigation

            // Navigate to the payment success screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PaymentSuccessScreen()),
            ).then((_) {
              // Update state for the cart
              setState(() {});
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Cart>>(
              future: _getProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("Không có sản phẩm trong giỏ hàng"),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final itemProduct = snapshot.data![index];
                      return _buildProduct(itemProduct, context);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FutureBuilder<List<Cart>>(
                future: _getProducts(),
                builder: (context, snapshot) {
                  double totalAmount = 0;
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData &&
                      snapshot.data!.isNotEmpty) {
                    // Calculate total amount if there are products
                    totalAmount = snapshot.data!.fold(
                      0,
                      (previousValue, element) => previousValue + (element.price * element.count),
                    );
                  }

                  // VAT rate
                  const vatRate = 0.08;
                  double vatAmount = totalAmount * vatRate;

                  // Total amount including VAT
                  double totalAmountWithVAT = totalAmount + vatAmount;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Tổng tiền: ${NumberFormat('#,###.###đ').format(totalAmount)}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'VAT (8%): ${NumberFormat('#,###.###đ').format(vatAmount)}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Tổng tiền thanh toán: ${NumberFormat('#,###.###đ').format(totalAmountWithVAT)}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _showPaymentDialog,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.black,
                     minimumSize: Size(100, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text("Thanh toán"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProduct(Cart pro, BuildContext context) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: BorderSide(color: Colors.black, width: 1.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130.0,
            height: 130.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: pro.img != null && pro.img.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(pro.img),
                      fit: BoxFit.cover,
                    )
                  : null,
              color: Colors.grey[200],
            ),
            child: pro.img == null || pro.img.isEmpty
                ? const Icon(Icons.image, size: 50)
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pro.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  NumberFormat('#,###.###đ').format(pro.price * pro.count),
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          DatabaseHelper().minus(pro);
                        });
                      },
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      pro.count.toString(),
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          DatabaseHelper().add(pro);
                        });
                      },
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Dropdown button for size selection below quantity buttons
                DropdownButton<String>(
                  value: _selectedSize,
                  hint: const Text('Chọn size'),
                  items: ['38', '39', '40', '41', '42']
                      .map((size) => DropdownMenuItem<String>(
                            value: size,
                            child: Text(size),
                          ))
                      .toList(),
                  onChanged: (String? newSize) {
                    setState(() {
                      _selectedSize = newSize;
                    });
                  },
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                DatabaseHelper().deleteProduct(pro.productID);
              });
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    ),
  );
}
}

class PaymentDialog extends StatefulWidget {
  final VoidCallback onConfirm;

  const PaymentDialog({required this.onConfirm, Key? key}) : super(key: key);

  @override
  _PaymentDialogState createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  String? paymentMethod;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Chọn phương thức thanh toán'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Image.asset('assets/images/Cash_Logo.png', width: 30, height: 30), // Custom logo for cash payment
            title: const Text('Thanh toán tiền mặt'),
            trailing: Radio<String>(
              value: 'cash',
              groupValue: paymentMethod,
              onChanged: (String? value) {
                setState(() {
                  paymentMethod = value;
                });
              },
              activeColor: Colors.black, // Set the color of the radio button
            ),
          ),
          ListTile(
            leading: Image.asset('assets/images/MoMo_Logo.png', width: 30, height: 30), // Custom logo for Momo payment
            title: const Text('Thanh toán Momo'),
            trailing: Radio<String>(
              value: 'momo',
              groupValue: paymentMethod,
              onChanged: (String? value) {
                setState(() {
                  paymentMethod = value;
                });
              },
              activeColor: Colors.black, // Set the color of the radio button
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black, // Text color // Button background color
          ),
          child: const Text('Hủy'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, // Text color
            backgroundColor: Colors.black, // Button background color
          ),
          child: const Text('Xác nhận thanh toán'),
          onPressed: () {
            if (paymentMethod != null) {
              widget.onConfirm();
            }
          },
        ),
      ],
    );
  }
}



