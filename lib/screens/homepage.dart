import 'package:flutter/material.dart';
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late List<bool> _favorites;

  Future<List<dynamic>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data; // Return the list of products
    } else {
      throw Exception('Failed to load products');
    }
  }

  late Future<List<dynamic>> _products;

  @override
  void initState() {
    super.initState();
    _favorites = List.generate(10, (_) => false);
    _products = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 21, 21, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 21, 21, 1),
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            'Hello,\nNadine',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
            color: Colors.white,
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Failed to load products',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else if (snapshot.hasData) {
            final products = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(35, 35, 39, 1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.white),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Discount Banner
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 98, 248, 103),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          const Positioned(
                            top: 20,
                            left: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '55 %',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  'Discount\nWireless Noise',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Image.asset(
                              'assets/images/earbuds.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Featured Section
                    const Text(
                      'Featured',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(7, (index) {
                          final product = products[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _buildProductCard(
                              product['title'],
                              '₹ ${product['price']}',
                              product['image'],
                              index, // Pass index here
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // All Section
                    const Text(
                      'All',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return _buildListTile(product['title'],
                            '₹ ${product['price']}', product['image'], index);
                      },
                    ),
                    const SizedBox(height: 10),

                    const Text(
                      'Explore more',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing: 15.0, // Horizontal spacing
                        mainAxisSpacing: 13.0, // Vertical spacing
                        childAspectRatio: 0.80, // Aspect ratio of the cards
                      ),
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return _buildProductCard(
                          product['title'],
                          '₹ ${product['price']}',
                          product['image'],
                          index,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'No products available',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildProductCard(
      String title, String price, String imageUrl, int index) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(35, 35, 39, 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Product Title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Product Price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _favorites[index] = !_favorites[
                          index]; // Toggle favorite state for the product
                    });
                  },
                  icon: Icon(
                    _favorites[index] ? Icons.favorite : Icons.favorite_border,
                    color: _favorites[index]
                        ? Colors.yellow
                        : Colors.white, // Toggle color based on state
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
      String title, String price, String imageUrl, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        tileColor: const Color.fromRGBO(35, 35, 39, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: ClipRRect(
          borderRadius:
              BorderRadius.circular(8), // Rounded corners for the image
          child: Image.network(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover, // Ensure the image scales properly
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.image,
                  color: Colors.grey); // Placeholder for errors
            },
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              price,
              style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _favorites[index] = !_favorites[
                      index]; // Toggle the favorite state for the specific product
                });
              },
              icon: Icon(
                _favorites[index] ? Icons.favorite : Icons.favorite_border,
                color: _favorites[index]
                    ? Colors.yellow
                    : Colors.white, // Change color based on state
              ),
            ),
          ],
        ),
      ),
    );
  }
}
