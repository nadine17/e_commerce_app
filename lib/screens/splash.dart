import 'package:e_commerce_app/screens/mainScreen.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Mainscreen()));
          },
          child: Image.asset(
            width: 500,
            'assets/images/spalsh.jpeg',
            fit: BoxFit.cover,
          )),
    );
  }
}
