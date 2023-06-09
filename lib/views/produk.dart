import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payu/views/cart.dart';
import 'package:payu/views/produkdetail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:payu/app/api.dart';
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
      // print(produkData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff151515),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Produk Market',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('No')),
                        DataColumn(label: Text('Nama Produk')),
                        DataColumn(label: Text('Kategori')),
                        DataColumn(label: Text('Deskripsi')),
                        DataColumn(label: Text('Stok')),
                        DataColumn(label: Text('Harga')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: List<DataRow>.generate(
                        produkData.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(Text((index + 1).toString())),
                            DataCell(
                                Text(produkData[index]['nama'].toString())),
                            DataCell(Text(produkData[index]['kategori']['nama']
                                .toString())),
                            DataCell(Text(
                                produkData[index]['deskripsi'].toString())),
                            DataCell(
                                Text(produkData[index]['stok'].toString())),
                            DataCell(
                              Text(
                                NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'Rp ',
                                ).format(double.parse(
                                    produkData[index]['harga'] ?? '0')),
                              ),
                            ),
                            DataCell(
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProdukDetail(
                                        id: produkData[index]['id'],
                                        nama: produkData[index]['nama'],
                                        kategori: produkData[index]['kategori']
                                                ['nama']
                                            .toString(),
                                        deskripsi: produkData[index]
                                                ['deskripsi']
                                            .toString(),
                                        stok: produkData[index]['stok']
                                            .toString(),
                                        harga: produkData[index]['harga']
                                            .toString(),
                                        data: getProdukDetail(
                                            produkData[index]['id']),
                                      ),
                                    ),
                                  );
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const cartScreen(),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
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
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
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

  Future<List<Map<String, dynamic>>> getProdukDetail(int id) async {
    var res = await Network().getData('/product/$id');
    var body = json.decode(res.body);

    // print(body['data']['data']);
    if (body['data'] != null) {
      return List<Map<String, dynamic>>.from(body['data']);
    }

    return []; // Return an empty list if there's an error or no data
  }
}
