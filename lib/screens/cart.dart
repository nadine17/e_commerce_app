import 'package:flutter/material.dart';
import 'checkout.dart';  // Import CheckoutPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShoppingPage(),
    );
  }
}

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  List<Map<String, dynamic>> items = [
    {'image': 'image/chair1.png', 'name': 'Minimalist Chair', 'brand': 'Regal Do Lobo', 'price': 279.95, 'quantity': 4},
    {'image': 'image/chair2.png', 'name': 'Hallingdal Chair', 'brand': 'Hatil-Loren', 'price': 258.91, 'quantity': 1},
    {'image': 'image/chair3.png', 'name': 'Hiro Armchair', 'brand': 'Hatil-Loren', 'price': 369.86, 'quantity': 3},
  ];

  double deliveryFee = 80.00;

  // Calculate subtotal
  double subtotal() {
    return items.fold(0.0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  // Calculate total payment
  double totalPayment() {
    return subtotal() + deliveryFee;
  }

  // Increment item quantity
  void incrementQuantity(int index) {
    setState(() {
      items[index]['quantity']++;
    });
  }

  // Decrement item quantity
  void decrementQuantity(int index) {
    setState(() {
      if (items[index]['quantity'] > 0) {
        items[index]['quantity']--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        title: const Text(
          "Shopping",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ShoppingCartItem(
                  image: items[index]['image'],
                  name: items[index]['name'],
                  brand: items[index]['brand'],
                  price: items[index]['price'],
                  quantity: items[index]['quantity'],
                  onIncrement: () => incrementQuantity(index),
                  onDecrement: () => decrementQuantity(index),
                );
              },
            ),
          ),
          OrderSummary(
            subtotal: subtotal(),
            deliveryFee: deliveryFee,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.teal,
              ),
              onPressed: () {
                // Pass the total payment value to the CheckoutPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutPage(totalAmount: totalPayment()),
                  ),
                );
              },
              child: const Text(
                "Check Out",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShoppingCartItem extends StatelessWidget {
  final String image;
  final String name;
  final String brand;
  final double price;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ShoppingCartItem({
    Key? key,
    required this.image,
    required this.name,
    required this.brand,
    required this.price,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Image.asset(image, width: 60, height: 60, fit: BoxFit.cover),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  brand,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  "\$${price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: onDecrement,
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(fontSize: 16),
              ),
              IconButton(
                onPressed: onIncrement,
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;

  const OrderSummary({
    Key? key,
    required this.subtotal,
    required this.deliveryFee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = subtotal + deliveryFee;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SummaryRow(label: "Subtotal", value: subtotal),
          const SizedBox(height: 8),
          SummaryRow(label: "Delivery Fee", value: deliveryFee),
          const Divider(height: 24, thickness: 1),
          SummaryRow(label: "Total Payment", value: total, isBold: true),
        ],
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isBold;

  const SummaryRow({
    Key? key,
    required this.label,
    required this.value,
    this.isBold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          "\$${value.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 16,
            color: isBold ? Colors.black : Colors.orange,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
