import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/api.dart';

class cartScreen extends StatefulWidget {
  const cartScreen({super.key});

  @override
  State<cartScreen> createState() => cartScreeneState();
}

class cartScreeneState extends State<cartScreen> {
  List<Map<String, dynamic>> cartData = [];

  @override
  void initState() {
    super.initState();
    loadProdukData();
  }

  Future<void> loadProdukData() async {
    List<Map<String, dynamic>> data = await getProdukData();

    setState(() {
      cartData = data;
      print(cartData);
    });
  }

  void removeItem(int index) {
    setState(() {
      cartData.removeAt(index);
    });
    print(cartData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('No')),
              DataColumn(label: Text('Nama Produk')),
              DataColumn(label: Text('Kuantitas')),
              DataColumn(label: Text('Harga')),
              DataColumn(label: Text('Action')),
            ],
            rows: List.generate(
              cartData.length,
              (index) {
                final item = cartData[index];
                return DataRow(
                  cells: [
                    DataCell(Text((index + 1).toString())),
                    DataCell(Text(item['nama'].toString())),
                    DataCell(Text(item['jumlah'].toString())),
                    DataCell(Text(item['harga'].toString())),
                    DataCell(ElevatedButton(
                        onPressed: () {
                          removeItem(index);
                        },
                        child: const Icon(Icons.delete))),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getProdukData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? cartCookie = localStorage.getString('cart');
    print(cartCookie);
    String jsonString = '''$cartCookie''';

    List jsonArray = jsonString
        .split(';')
        .map((item) => jsonDecode(item))
        .toList()
        .cast<String>();

    print(jsonArray);
    print("===================");

    try {
      List<Map<String, dynamic>> decodedCartData = [];
      var user = jsonDecode(localStorage.getString('user') ?? '');
      int id = user['id'];
      for (String cookie in jsonArray) {
        Map<String, dynamic> data = json.decode(cookie);
        final int key = int.parse(data.keys.first);
        final Map<String, dynamic> value = data.values.first;
        final int idUser = value['iduser'];
        if (idUser == id) {
          bool isProductExist = false;

          for (Map<String, dynamic> entry in decodedCartData) {
            if (entry['id'] == key) {
              entry['jumlah'] += value['jumlah'];
              isProductExist = true;
              break;
            }
          }

          if (!isProductExist) {
            Map<String, dynamic> entry = {
              'id': key,
              'nama': value['nama'],
              'harga': value['harga'],
              'jumlah': value['jumlah'],
              'iduser': value['iduser']
            };
            decodedCartData.add(entry);
          }
        }
      }
      cartData = decodedCartData;

      return cartData;
    } catch (e) {
      print('Error decoding cart cookie: $e');
    }

    return [];
  }
}
