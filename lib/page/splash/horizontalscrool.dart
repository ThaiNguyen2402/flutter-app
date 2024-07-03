import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HorizontalScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 400.0, // Giữ nguyên chiều cao
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlayAnimationDuration: Duration(milliseconds: 500),
                  autoPlayCurve: Curves.easeInOut,
                  pauseAutoPlayOnTouch: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                ),
                items: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/cate1.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/cate2.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/cate1.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/cate4.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/Logo1.png', height: 50, width: 150),
                SizedBox(height: 5.0),
                Text(
                  'Mang đến cho thành viên của Fein những sản phẩm, nguồn cảm hứng và câu chuyện hay nhất trong thể thao.',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text('Đăng ký',
                          style: TextStyle(color: Colors.black)),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'hoặc',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text('Đăng nhập',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
