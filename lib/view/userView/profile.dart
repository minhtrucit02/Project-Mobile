import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shose_store/view/userView/providers.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDao = ref.watch(userDaoProvider);

    return Drawer(
      backgroundColor: const Color(0xFF0D1B2A),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO: add Avatar & Name
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      // backgroundImage: AssetImage("assets/avatar.jpg"),
                    ),
                    const SizedBox(height: 10),
                    const Text("Hey, 👋", style: TextStyle(color: Colors.white70)),
                    Text(
                      userDao.email() ?? "User",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Menu Items
              _buildMenuItem(Icons.person, "Profile"),
              _buildMenuItem(Icons.home, "Home Page"),
              _buildMenuItem(Icons.shopping_bag_outlined, "My Cart"),
              _buildMenuItem(Icons.favorite_border, "Favorite"),
              _buildMenuItem(Icons.local_shipping_outlined, "Orders"),
              _buildMenuItem(Icons.notifications_none, "Notifications"),

              const Spacer(),

              const Divider(color: Colors.white24),
              _buildMenuItem(Icons.logout, "Sign Out", onTap: () {
                ref.read(userDaoProvider).logout();
                Navigator.of(context).pushReplacementNamed("/login");
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }
}
