import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:payu/app/api.dart';
import 'buttonnav.dart';
import 'home.dart';
import 'login.dart';

class KasirScreen extends StatelessWidget {
  const KasirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle button press
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/123.jpg',
            width: 24, // Adjust the width as needed
            height: 24,
            // Adjust the height as needed
          ),
          const SizedBox(
              width: 8), // Adjust the spacing between the image and text
          const Text(
            '1',
            style: TextStyle(fontSize: 16), // Adjust the font size as needed
          ),
        ],
      ),
    );
  }
}
