
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget{
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.more_vert),
            Column(
              children: [
                Text("Shoes Store", style: TextStyle(fontSize: 24),),
              ],
            ),
            Stack(
              children: [
                Icon(Icons.shopping_bag_outlined,size: 28,),
                Positioned(
                    right: 0,
                    child: CircleAvatar(radius: 4,backgroundColor: Colors.red,)
                )
              ],
            ),
          ],
        )
      ],
    );
  }

}