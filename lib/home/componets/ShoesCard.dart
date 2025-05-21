import 'package:flutter/material.dart';

class ShoesCard extends StatelessWidget {
  const ShoesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.apply(
      displayColor: Theme.of(context).colorScheme.onSurface,
    );

    return Container(
      constraints: const BoxConstraints(maxWidth: 170),
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
                  child: Image.asset("assets/nike/air_force_1.png", fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 8.0,
                  left: 8.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    color: Colors.white.withOpacity(0.7),
                    child: Text(
                      "BEST SELLER",
                      style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              title: Text("Air Force 1", style: textTheme.titleMedium),
              subtitle: Text("\$129.99", style: textTheme.bodySmall),
              trailing: const Icon(Icons.add, color: Colors.blue),
              onTap: () {
                ;
              },
            ),
          ],
        ),
      ),
    );
  }
}
