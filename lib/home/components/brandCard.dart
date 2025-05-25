import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  final String brand;
  final String logo;
  final bool isSelected;

  const BrandCard({super.key, required this.brand, required this.logo, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            logo,
            width: 24,
            height: 24,
          ),
          if (isSelected) ...[
            SizedBox(width: 8),
            Text(
              brand,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
