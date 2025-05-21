import 'package:flutter/material.dart';
import 'package:shose_store/home/componets/ShoesCardWidget.dart';
import 'package:shose_store/home/componets/TopBar.dart';

import 'componets/ShoesCard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // TODO: current tab
  int tab = 0;

  //TODO: define tab bar destinations
  List<NavigationDestination> appBarDestinations = const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
      selectedIcon: Icon(Icons.home_outlined),
    ),
    NavigationDestination(
      icon: Icon(Icons.favorite_border_outlined),
      label: 'Favorite',
      selectedIcon: Icon(Icons.favorite_border_outlined),
    ),
    NavigationDestination(
      icon: Icon(Icons.notifications_none),
      label: 'Notification',
      selectedIcon: Icon(Icons.notifications_none),
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outlined),
      label: 'Person',
      selectedIcon: Icon(Icons.person_outlined),
    ),
  ];
  List<String> brands = [
    'Nike','Puma', 'Under Armour', 'Adidas', 'Converse'
  ];
  @override
  Widget build(BuildContext context) {
    //TODO: define page
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: TopBar()),
      body: Padding(padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              SearchBar(),
              const SizedBox(height: 40,),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: brands.map((brand){
                    return Padding(
                        padding: const EdgeInsets.only(right: 10),
                      child: Chip(
                          backgroundColor: brand == 'Nike' ? Colors.blue : Colors.grey[200],
                          label: Text(
                            brand,
                            style: TextStyle(
                              color: brand == 'Nike' ? Colors.white : Colors.black,
                            ),
                          )),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    ShoesCard(),
                    SizedBox(width: 8),
                    ShoesCard(),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ShoesCardWidget(),
                    ShoesCardWidget(),
                  ],
                ),
              ),

            ],
          ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (index) {
          setState(() {
            tab = index;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: appBarDestinations,
      ),
    );
  }
}
