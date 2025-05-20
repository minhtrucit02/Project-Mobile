import 'package:flutter/material.dart';

class ShoesCard extends StatelessWidget{
  const ShoesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.apply(displayColor:
    Theme.of(context).colorScheme.onSurface);

    return Card(
      child:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //TODO: add Stack widget
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8.0),
                ),
                // child: Image.asset(),
              ),
              Positioned(
                  top: 16.0,
                  left: 16.0,
                  child: Text("Nike",
                  style: textTheme.headlineLarge,)),
              Positioned(
                bottom: 16.0,
                  right: 16.0,
                  child: RotatedBox(quarterTurns: 1,
                  child: Text("Jordan",style: textTheme.headlineLarge,),))
            ],
          ),

          //TODO: add listTitle widget
        ],
      ),
    );
  }

}