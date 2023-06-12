import 'package:flutter/cupertino.dart';

class Cart {
  int? id;
  String? productId;
  String? productName;
  int? productPrice;
  ValueNotifier<int>? quantity;
  String? kategori;
  String? image;

  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.kategori,
    required this.image,
  });

  Cart.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
        productId = data['productId'],
        productName = data['productName'],
        productPrice = data['productPrice'],
        quantity = ValueNotifier<int>(data['quantity']),
        kategori = data['kategori'],
        image = data['image'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity?.value,
      'kategori': kategori,
      'image': image,
    };
  }
}
