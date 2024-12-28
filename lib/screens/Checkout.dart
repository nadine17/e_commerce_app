import 'package:flutter/material.dart';
import 'payment.dart';  // Import the PaymentPage class file

class CheckoutPage extends StatefulWidget {
  final double totalAmount;  // Accept total amount from ShoppingPage

  const CheckoutPage({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedAddress = 'Home Address'; // Track the selected address
  String _selectedPaymentMethod = 'Credit Card'; // Track the selected payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shipping To',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildAddressOption(
              title: 'Home Address',
              phone: '(269) 444-8853',
              address: 'karnak, luxor',
              isSelected: _selectedAddress == 'Home Address',
            ),
            const SizedBox(height: 8),
            _buildAddressOption(
              title: 'Office Address',
              phone: '259-444-6853',
              address: 't.v street, luxor',
              isSelected: _selectedAddress == 'Office Address',
            ),
            const SizedBox(height: 16),
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildPaymentOption('Credit Card', Icons.credit_card),
            _buildPaymentOption('Paypal', Icons.payment),
            _buildPaymentOption('Apple Pay', Icons.apple),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildAmountRow('Item Total', '\$${widget.totalAmount.toStringAsFixed(2)}', isBold: true),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to PaymentPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(), // Navigate to PaymentPage
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Payment',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressOption({
    required String title,
    required String phone,
    required String address,
    required bool isSelected,
  }) {
    return ListTile(
      leading: Radio<String>(
        value: title,
        groupValue: _selectedAddress,
        onChanged: (value) {
          setState(() {
            _selectedAddress = value!;
          });
        },
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('$phone\n$address'),
      isThreeLine: true,
      trailing: const Icon(Icons.edit),
      onTap: () {
        setState(() {
          _selectedAddress = title;
        });
      },
    );
  }

  Widget _buildPaymentOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Radio<String>(
        value: title,
        groupValue: _selectedPaymentMethod,
        onChanged: (value) {
          setState(() {
            _selectedPaymentMethod = value!;
          });
        },
      ),
      onTap: () {
        setState(() {
          _selectedPaymentMethod = title;
        });
      },
    );
  }

  Widget _buildAmountRow(String label, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 16 : 14,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 16 : 14,
            color: isBold ? Colors.teal : Colors.black,
          ),
        ),
      ],
    );
  }
}
