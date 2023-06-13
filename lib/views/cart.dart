import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/api.dart';

class cartScreen extends StatefulWidget {
  const cartScreen({Key? key});

  @override
  State<cartScreen> createState() => cartScreeneState();
}

class cartScreeneState extends State<cartScreen> {
  List<Map<String, dynamic>> cartData = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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

  Future<void> showCustomerDataDialog() async {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController namaController = TextEditingController();
    final TextEditingController noHpController = TextEditingController();
    final TextEditingController alamatController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Customer Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: noHpController,
                decoration: const InputDecoration(labelText: 'No HP'),
              ),
              TextField(
                controller: alamatController,
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle the submitted customer data
                final customerData = {
                  'email': emailController.text,
                  'nama': namaController.text,
                  'noHp': noHpController.text,
                  'alamat': alamatController.text,
                };
                // Process the customer data here
                // ...
                checkout(customerData);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCustomerDataDialog();
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getProdukData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? cartCookie = localStorage.getString('cart');
    // print(cartCookie);
    String jsonString = '''$cartCookie''';

    List jsonArray = jsonString
        .split(';')
        .map((item) => jsonDecode(item))
        .toList()
        .cast<String>();

    // print(jsonArray);
    // print("===================");

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

  void checkout(customerData) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var nama = customerData['nama'];
    var email = customerData['email'];
    var alamat = customerData['alamat'];
    var noHp = customerData['noHp'];
    var cart = jsonEncode(getProdukData());

    print(cart);

    var data = {
      'nama': nama,
      'email': email,
      'alamat': alamat,
      'noHp': noHp,
      'cart': cart
    };

    var res = await Network().postData(data, '/cashier/transaksi');
    print(data);
    var body = json.decode(res.body);
    if (body['message'] == 'Transaction successful') {
      // Navigator.pop(context);
      print("ini cartnya");
      print(body['cart']);
      _showMsg(body['message']);
    } else {
      _showMsg(body['message']);
      print(body['message']);
    }
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    if (_scaffoldKey.currentState != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(snackBar);
    }
  }
}
