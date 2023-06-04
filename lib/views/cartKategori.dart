import 'dart:convert';
import 'package:flutter/material.dart';
import '../app/api.dart';

class cartKategoriScreen extends StatefulWidget {
  const cartKategoriScreen({
    super.key,
    required Future<List> data,
  });

  @override
  State<cartKategoriScreen> createState() => _cartKategoriScreenState();
}

class _cartKategoriScreenState extends State<cartKategoriScreen> {
  List<Map<String, dynamic>> produkData = [];

  @override
  void initState() {
    super.initState();
    // loadProdukData();
  }

  // Future<void> loadProdukData() async {
  //   List<Map<String, dynamic>> data = await widget.data;
  //   setState(() {
  //     produkData = data;
  //     print(produkData);
  //   });
  // }

  Future<List<Map<String, dynamic>>> getProdukData(int kategori) async {
    var res = await Network().getData('cashier/kategori/$kategori');
    var body = json.decode(res.body);

    // print(body['data']['data']);
    if (body['data'] != null) {
      return List<Map<String, dynamic>>.from(body['data']['data']);
    }
    return []; // Return an empty list if there's an error or no data
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1194;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Product"),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(39 * fem, 0 * fem, 26 * fem, 53 * fem),
        padding: EdgeInsets.fromLTRB(28.81 * fem, 19 * fem, 28 * fem, 20 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff313131),
          borderRadius: BorderRadius.circular(10 * fem),
        ),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('dd'),
            )
          ],
        ),
      ),
    );
  }
}
