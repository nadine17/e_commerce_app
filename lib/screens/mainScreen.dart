import 'package:e_commerce_app/screens/OrderConfirmationScreen.dart';
import 'package:e_commerce_app/screens/fav.dart';
import 'package:e_commerce_app/screens/homepage.dart';
import 'package:e_commerce_app/screens/sign.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/screens/search.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Mainscreen> {
  int _currentIndex = 0;

  // List of pages to display for each index
  final List<Widget> _pages = [
    const Homepage(),
    const SearchPage(),
    const Fav(),
    const Sign(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 35, 39, 1),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: _currentIndex == 0 ? Colors.yellow : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: _currentIndex == 1 ? Colors.yellow : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            const SizedBox(width: 48), // Space for the FAB
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: _currentIndex == 2 ? Colors.yellow : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: _currentIndex == 3 ? Colors.yellow : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.shopping_cart_checkout_outlined,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const OrderConfirmationScreen()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
