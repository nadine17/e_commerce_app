import 'package:e_commerce_app/screens/homepage.dart';
import 'package:flutter/material.dart';

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
    const EmotionsPage(),
    const ProfilePage(),
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
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () {
                // Action for the profile icon
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
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// Home page widget
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Home Page',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}

// Emotions page widget
class EmotionsPage extends StatelessWidget {
  const EmotionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Explore categories',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}

// Profile page widget
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Favorites Page',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
