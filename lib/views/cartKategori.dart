import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app/api.dart';
import 'cart.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class cartKategoriScreen extends StatefulWidget {
  final Future<List<dynamic>> data;

  const cartKategoriScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<cartKategoriScreen> createState() => _cartKategoriScreenState();
}

class _cartKategoriScreenState extends State<cartKategoriScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> produkData = [];
  List<int> quantities = [];
  List<TextEditingController> quantityControllers = [];

  @override
  void initState() {
    super.initState();
    loadProdukData();
  }

  Future<void> loadProdukData() async {
    List<dynamic> data = await widget.data;
    setState(() {
      produkData = List<Map<String, dynamic>>.from(data);
      quantities = List<int>.filled(data.length, 1);
      quantityControllers = List<TextEditingController>.generate(
        data.length,
        (index) => TextEditingController(text: '1'),
      );
      // print(produkData);
    });
  }

  @override
  void dispose() {
    for (var controller in quantityControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    if (_scaffoldKey.currentState != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1194;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      key: _scaffoldKey,
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
            SizedBox(height: 16 * fem),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                produkData.length,
                (index) => Container(
                  constraints: const BoxConstraints(
                      maxWidth:
                          300), // Sesuaikan lebar maksimum yang diinginkan
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0 * fem),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${produkData[index]['nama']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Harga: ${NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(double.parse(produkData[index]['harga'] ?? '0'))}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (quantities[index] > 1) {
                                      quantities[index]--;
                                      quantityControllers[index].text =
                                          quantities[index].toString();
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextFormField(
                                  controller: quantityControllers[index],
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      quantities[index] =
                                          int.tryParse(value) ?? 1;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Jumlah',
                                    labelStyle: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    quantities[index]++;
                                    quantityControllers[index].text =
                                        quantities[index].toString();
                                  });
                                },
                                icon: Icon(Icons.add),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  postCartItem(
                                      produkData[index]['id'],
                                      produkData[index]['nama'],
                                      quantities[index],
                                      produkData[index]['harga']);
                                  print(
                                      "${produkData[index]['nama']} sejumlah ${quantities[index]} dengan harga ${produkData[index]['harga']} berhasil ditambah");
                                },
                                child: const Text(
                                  '+',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
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
    );
  }

  Future<void> postCartItem(
      int id, String nama, int kuantiti, String harga) async {
    final apiUrl = '/cashier/tambah/$id';

    final data = {
      'id': id,
      'jumlah': kuantiti,
    };

    try {
      final response = await Network().postData(data, apiUrl);
      print(response.body);
      print(response.headers);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        final responseData = json.decode(response.body);
        final data = responseData['data'];
        final cookie = data != null ? json.encode(data) : null;

        SharedPreferences localStorage = await SharedPreferences.getInstance();
        final currentCartCookie = localStorage.getString('cart');
        String? newCartCookie;

        if (currentCartCookie != null) {
          newCartCookie = '$currentCartCookie;$cookie';
        } else {
          newCartCookie = cookie;
        }

        await localStorage.setString('cart', newCartCookie!);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const cartScreen()),
        );
      } else {
        _showMsg("Stok Habis");
      }
    } catch (e) {
      _showMsg("Stok Habis ");
    }
  }
}
