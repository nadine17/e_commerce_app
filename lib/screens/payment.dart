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
  final TextEditingController _paypalEmailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  void _onPaymentMethodChanged(String? method) {
    setState(() {
      selectedPaymentMethod = method;
      _clearInputs();
    });
  }

  void _clearInputs() {
    _cardNumberController.clear();
    _expiryDateController.clear();
    _cvvController.clear();
    _paypalEmailController.clear();
    _addressController.clear();
    _cityController.clear();
    _postalCodeController.clear();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment Successful!')),
      );
      Navigator.pop(context); // Go back to checkout page or home page
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please correct the errors in the form.')),
      );
    }
  }

  Widget _buildPaymentDetailsForm() {
    switch (selectedPaymentMethod) {
      case 'Credit Card':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter Card Details:', style: TextStyle(color: Colors.black)),
            SizedBox(height: 10),
            TextFormField(
              controller: _cardNumberController,
              decoration: _inputDecoration('Card Number'),
              keyboardType: TextInputType.number,
              validator: (value) =>
              value == null || value.length != 16 ? 'Enter a valid card number' : null,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _expiryDateController,
              decoration: _inputDecoration('Expiry Date (MM/YY)'),
              keyboardType: TextInputType.datetime,
              validator: (value) =>
              value == null || !RegExp(r'^\d{2}/\d{2}$').hasMatch(value)
                  ? 'Enter a valid expiry date'
                  : null,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _cvvController,
              decoration: _inputDecoration('CVV'),
              obscureText: true,
              keyboardType: TextInputType.number,
              validator: (value) =>
              value == null || value.length != 3 ? 'Enter a valid CVV' : null,
            ),
          ],
        );
      case 'PayPal':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter PayPal Email:', style: TextStyle(color: Colors.black)),
            SizedBox(height: 10),
            TextFormField(
              controller: _paypalEmailController,
              decoration: _inputDecoration('Email Address'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
              value == null || !value.contains('@') ? 'Enter a valid email address' : null,
            ),
          ],
        );
      case 'Cash on Delivery':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter Delivery Address:', style: TextStyle(color: Colors.black)),
            SizedBox(height: 10),
            TextFormField(
              controller: _addressController,
              decoration: _inputDecoration('Street Address'),
              validator: (value) => value == null || value.isEmpty ? 'Enter a valid address' : null,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _cityController,
              decoration: _inputDecoration('City'),
              validator: (value) => value == null || value.isEmpty ? 'Enter a valid city' : null,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _postalCodeController,
              decoration: _inputDecoration('Postal Code'),
              keyboardType: TextInputType.number,
              validator: (value) =>
              value == null || value.length != 5 ? 'Enter a valid postal code' : null,
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      border: OutlineInputBorder(),
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.grey[200],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context), // Go back to previous page
          ),
          title: Text('Payment'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Payment Method', style: TextStyle(color: Colors.black)),
              ListTile(
                title: Text('Credit Card', style: TextStyle(color: Colors.black)),
                leading: Radio<String>(
                  value: 'Credit Card',
                  groupValue: selectedPaymentMethod,
                  onChanged: _onPaymentMethodChanged,
                ),
              ),
              ListTile(
                title: Text('PayPal', style: TextStyle(color: Colors.black)),
                leading: Radio<String>(
                  value: 'PayPal',
                  groupValue: selectedPaymentMethod,
                  onChanged: _onPaymentMethodChanged,
                ),
              ),
              ListTile(
                title: Text('Cash on Delivery', style: TextStyle(color: Colors.black)),
                leading: Radio<String>(
                  value: 'Cash on Delivery',
                  groupValue: selectedPaymentMethod,
                  onChanged: _onPaymentMethodChanged,
                ),
              ),
              if (selectedPaymentMethod != null) ...[
                SizedBox(height: 20),
                Form(key: _formKey, child: _buildPaymentDetailsForm()),
              ],
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Confirm Order', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}