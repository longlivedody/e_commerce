import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';
import '../screens/favorite_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

int currentIndex = 0;

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 25.0,
        iconSize: 21,
        selectedIconTheme: const IconThemeData(size: 26.0),
        selectedFontSize: 15,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            // Add this item for the ProfileScreen
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
      ),
      appBar: AppBar(
        title: _buildTitle(),
      ),
      drawer: const Drawer(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const FavoriteScreen();
      case 2:
        return const CartScreen();
      case 3:
        return const ProfileScreen();
      default:
        return Container();
    }
  }

  Widget _buildTitle() {
    switch (currentIndex) {
      case 0:
        return const Text('Home');
      case 1:
        return const Text('Favorites');
      case 2:
        return const Text('Cart');
      case 3:
        return const Text('Profile');
      default:
        return Container();
    }
  }
}
