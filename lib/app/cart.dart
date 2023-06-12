import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CartManager {
  static Future<SharedPreferences> _getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> addToCart(Map<String, dynamic> productData) async {
    final SharedPreferences sharedPreferences = await _getSharedPreferences();
    final String? cartData = sharedPreferences.getString('cart');

    if (cartData != null) {
      final Map<String, dynamic> existingCartData =
          json.decode(cartData) as Map<String, dynamic>;
      existingCartData.addAll(productData);
      sharedPreferences.setString('cart', json.encode(existingCartData));
    } else {
      sharedPreferences.setString('cart', json.encode(productData));
    }
  }

  static Future<Map<String, dynamic>> getCartData() async {
    final SharedPreferences sharedPreferences = await _getSharedPreferences();
    final String? cartData = sharedPreferences.getString('cart');

    if (cartData != null) {
      return json.decode(cartData) as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  static Future<void> clearCart() async {
    final SharedPreferences sharedPreferences = await _getSharedPreferences();
    sharedPreferences.remove('cart');
  }
}
