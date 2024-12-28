import 'package:e_commerce_app/screens/OrderConfirmationScreen.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _applePayController = TextEditingController();

  void _onPaymentMethodChanged(String? method) {
    setState(() {
      selectedPaymentMethod = method;
      _cardNumberController.clear();
      _expiryDateController.clear();
      _cvvController.clear();
      _addressController.clear();
      _cityController.clear();
      _postalCodeController.clear();
      _applePayController.clear();
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
    } else {
      // Form is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please correct the errors in the form.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Payment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Payment Method',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ListTile(
                title: Text('Credit Card', style: TextStyle(color: Colors.white)),
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.credit_card, color: Colors.blue),
                    SizedBox(width: 8),
                    Radio<String>(
                      value: 'Credit Card',
                      groupValue: selectedPaymentMethod,
                      onChanged: _onPaymentMethodChanged,
                      fillColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text('PayPal', style: TextStyle(color: Colors.white)),
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.account_balance_wallet, color: Colors.blue),
                    SizedBox(width: 8),
                    Radio<String>(
                      value: 'PayPal',
                      groupValue: selectedPaymentMethod,
                      onChanged: _onPaymentMethodChanged,
                      fillColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text('Apple Pay', style: TextStyle(color: Colors.white)),
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.apple, color: Colors.blue),
                    SizedBox(width: 8),
                    Radio<String>(
                      value: 'Apple Pay',
                      groupValue: selectedPaymentMethod,
                      onChanged: _onPaymentMethodChanged,
                      fillColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text('Cash on Delivery', style: TextStyle(color: Colors.white)),
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.local_shipping, color: Colors.blue),
                    SizedBox(width: 8),
                    Radio<String>(
                      value: 'Cash on Delivery',
                      groupValue: selectedPaymentMethod,
                      onChanged: _onPaymentMethodChanged,
                      fillColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ],
                ),
              ),
              if (selectedPaymentMethod != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    if (selectedPaymentMethod == 'Credit Card') ...[
                      Text(
                        'Enter Card Details:',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _cardNumberController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Card Number',
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.grey[800],
                              ),
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _expiryDateController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Expiry Date (MM/YY)',
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.grey[800],
                              ),
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.datetime,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _cvvController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'CVV',
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.grey[800],
                              ),
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                    ] else if (selectedPaymentMethod == 'PayPal') ...[
                      Text(
                        'Enter PayPal Email:',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email Address',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[800],
                        ),
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ] else if (selectedPaymentMethod == 'Apple Pay') ...[
                      Text(
                        'Enter Apple Pay Information:',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      TextField(
                        controller: _applePayController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Apple Pay Account Info',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[800],
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ] else if (selectedPaymentMethod == 'Cash on Delivery') ...[
                      Text(
                        'Enter Delivery Address:',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Street Address',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[800],
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'City',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[800],
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _postalCodeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Postal Code',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[800],
                        ),
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ],
                ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => OrderConfirmationScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Confirm Order',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
      ),
    ),
    home: PaymentPage(),
    debugShowCheckedModeBanner: false,
  ));
}
