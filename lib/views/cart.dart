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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ],
            rows: List.generate(
              cartData.length,
              (index) {
                final item = cartData[index];
                return DataRow(
                  cells: [
                    DataCell(Text((index + 1).toString())),
                    DataCell(Text(item['nama'].toString())),
                    DataCell(Text(item['harga'].toString())),
                    DataCell(Text(item['jumlah'].toString())),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNav(
      //   currentIndex: 2,
      //   onTabChanged: (index) {},
      // ),
    );
  }

  // Future<List<Map<String, dynamic>>> getProdukData1() async {
  //   var res = await Network().getData('/cashier/cart');
  //   var body = json.decode(res.body);

  //   List<Map<String, dynamic>> data = [];
  //   if (body['data'] != null) {
  //     print(body);
  //     body['data'].forEach((key, value) {
  //       Map<String, dynamic> entry = {
  //         'id': int.parse(key),
  //         'nama': value['nama'],
  //         'harga': value['harga'],
  //         'jumlah': value['jumlah'],
  //       };
  //       data.add(entry);
  //     });
  //   }
  //   return data;

  //   var res = await Network().getData('/cashier/cart');
  //   var body = json.decode(res.body);

  //   List<Map<String, dynamic>> data = [];
  //   if (body['data'] != null) {
  //     print(body);
  //     body['data'].forEach((key, value) {
  //       Map<String, dynamic> entry = {
  //         'id': int.parse(key),
  //         'nama': value['nama'],
  //         'harga': value['harga'],
  //         'jumlah': value['jumlah'],
  //       };
  //       data.add(entry);
  //     });
  //   }

  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   final currentCartCookie = localStorage.getString('cart');
  //   print(currentCartCookie); // Menampilkan nilai currentCartCookie

  //   if (currentCartCookie != null) {
  //     var cookieData = currentCartCookie.split(';');
  //     for (var cookie in cookieData) {
  //       var cookieValues = cookie.split('=');
  //       if (cookieValues.length == 2) {
  //         var key = cookieValues[0].trim();
  //         var value = cookieValues[1].trim();
  //         Map<String, dynamic> entry = {
  //           'id': int.parse(key),
  //           'jumlah': int.parse(value),
  //         };
  //         data.add(entry);
  //       }
  //     }
  //   }

  //   return data;
  // }

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
      print(id);
      for (String cookie in jsonArray) {
        Map<String, dynamic> data = json.decode(cookie);
        final int key = int.parse(data.keys.first);
        final Map<String, dynamic> value = data.values.first;
        final int idUser = value['iduser'];
        if (idUser == id) {
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
      cartData = decodedCartData;
      return cartData;
    } catch (e) {
      print('Error decoding cart cookie: $e');
    }

    return [];
  }
}
