import 'package:flutter/material.dart';

import '../../home/components/TopBar.dart';

class ShoesDetail extends StatelessWidget{
  const ShoesDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            children: [
              TopBar(),
              Expanded(
                child: Column(
                  children: [
                    Image.asset('assets/nike/air_force_1.png', height: 400),
                  ],
                ),
              ),
            ],
          )),
    );
  }

}