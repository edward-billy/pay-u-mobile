import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:payu/app/api.dart';
import 'buttonnav.dart';

import 'home.dart';
import 'login.dart';

class ProdukScreen extends StatefulWidget {
  @override
  State<ProdukScreen> createState() => _ProdukScreenState();
}

class _ProdukScreenState extends State<ProdukScreen> {
  List<Map<String, dynamic>> produkData = [];

  @override
  void initState() {
    super.initState();
    loadProdukData();
  }

  Future<void> loadProdukData() async {
    List<Map<String, dynamic>> data = await getProdukData();
    setState(() {
      produkData = data;
      print(produkData);
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
            columns: [
              const DataColumn(label: Text('No')),
              const DataColumn(label: Text('Nama Produk')),
              const DataColumn(label: Text('Kategori')),
              const DataColumn(label: Text('Deskripsi')),
              const DataColumn(label: Text('Stok')),
              const DataColumn(label: Text('Harga')),
              const DataColumn(label: Text('Action')),
            ],
            rows: List<DataRow>.generate(
              produkData.length,
              (index) => DataRow(
                cells: [
                  DataCell(Text((index + 1).toString())),
                  DataCell(Text(produkData[index]['nama'].toString())),
                  DataCell(
                      Text(produkData[index]['kategori']['nama'].toString())),
                  DataCell(Text(produkData[index]['deskripsi'].toString())),
                  DataCell(Text(produkData[index]['stok'].toString())),
                  DataCell(
                      Text('Rp. ${produkData[index]['harga'].toString()}-')),
                  DataCell(
                    ElevatedButton(
                      onPressed: () {
                        // Handle button press
                        // You can navigate to the detail screen here
                      },
                      child: const Text('Detail'),
                    ),
                  ),
                ],
              ),
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

  void logout() async {
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      localStorage.remove('user');
      localStorage.remove('token');
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
  }
}

Future<List<Map<String, dynamic>>> getProdukData() async {
  var res = await Network().getData('/product');
  var body = json.decode(res.body);

  // print(body['data']['data']);
  if (body['data'] != null) {
    return List<Map<String, dynamic>>.from(body['data']['data']);
  }
  return []; // Return an empty list if there's an error or no data
}
