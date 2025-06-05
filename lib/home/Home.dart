import 'package:flutter/material.dart';
import 'package:shose_store/home/components/BrandList.dart';
import 'package:shose_store/home/components/SearchCard.dart';
import 'package:shose_store/home/components/appBarCard.dart';
import 'package:shose_store/home/components/popularShoes/popular_shoes.dart';
import 'package:shose_store/view/userView/profile.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0: // Home
        break;
      case 1: // Favorite
        // TODO: Navigate to Favorite screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Navigating to Favorites...')),
        );
        break;
      case 2: // Shopping bag
        // TODO: Navigate to Cart screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening Shopping Bag...')),
        );
        break;
      case 3: // Notifications
        // TODO: Navigate to Notifications screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening Notifications...')),
        );
        break;
      case 4: // Profile
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Profile()));
        break;
    }
  }

  void _onMenuPressed() {
    // TODO: Open drawer or menu
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening menu...')),
    );
  }

  void _onShoppingBagPressed() {
    // TODO: Navigate to shopping bag
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening shopping bag...')),
    );
  }

  void _onSearchSubmitted(String value) {
    // TODO: Implement search functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Searching for: $value')),
    );
  }

  void _onSeeAllPopularPressed() {
    // TODO: Navigate to all popular shoes
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing all popular shoes...')),
    );
  }

  void _onSeeAllNewArrivalsPressed() {
    // TODO: Navigate to all new arrivals
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing all new arrivals...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: AppBarCard(),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Search Bar
                    SearchCard(),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: BrandList(),
              ),
            ),


            // Popular Shoes Title Row
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Popular Shoes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: _onSeeAllPopularPressed,
                      child: Text('See all', style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,),
                child: PopularShoes(),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('New Arrivals', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: _onSeeAllNewArrivalsPressed,
                      child: Text('See all', style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorite'),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              child: Icon(Icons.shopping_bag_outlined, color: Colors.white),
            ),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
