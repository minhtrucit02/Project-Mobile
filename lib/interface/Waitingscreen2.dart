import 'package:flutter/material.dart';
import '../home/Home.dart';

class WaitingScreen2 extends StatelessWidget {
  const WaitingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            children: [
              // Hình giày lớn ở giữa
              Expanded(
                flex: 6,
                child: Center(
                  child: Image.asset(
                    'assets/image/screen2.png', // bạn thay bằng đường dẫn hình bạn có
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Tiêu đề lớn
              const Text(
                'Follow Latest\nStyle Shoes',

                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height:5 ),

              // Mô tả nhỏ
              const Text(
                'There Are Many Beautiful And\nAttractive Plants To Your Room',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),

              const Spacer(),

              // Thanh chỉ báo trang nhỏ
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 15,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 15,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Nút Next
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                    // Xử lý khi bấm nút Next (có thể chuyển trang hoặc hành động khác)
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
