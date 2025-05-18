import 'package:flutter/material.dart';
import '../../models/Shoes.dart';

class ShoesCard extends StatelessWidget {
  const ShoesCard({super.key, required this.shoes});
  final Shoes shoes;

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Sample Placeholder for Shoe Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.image, size: 40, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            // Shoe Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(shoes.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 4),
                  Text("Brand: ${shoes.brand}"),
                  Text("Origin: ${shoes.origin}"),
                  const SizedBox(height: 4),
                  Text("Price: \$${shoes.price}",
                      style: const TextStyle(color: Colors.blue)),
                  // Text("MFG: ${dateFormat.format(shoes.mfgDate)}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
