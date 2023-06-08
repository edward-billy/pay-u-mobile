import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            SizedBox(height: 16 * fem),
            Row(
              children: [
                for (int index = 0; index < produkData.length; index++)
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0 * fem),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Barang: ${produkData[index]['nama']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16 * fem,
                              ),
                            ),
                            SizedBox(height: 8 * fem),
                            Text(
                              'Harga: ${NumberFormat.currency(locale: 'id', symbol: 'Rp').format(double.parse(produkData[index]['harga'] ?? '0'))}',
                              style: TextStyle(fontSize: 14 * fem),
                            ),
                            SizedBox(height: 8 * fem),
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
                                  icon: Icon(Icons.remove),
                                ),
                                SizedBox(width: 8 * fem),
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
                                    decoration: InputDecoration(
                                      labelText: 'Jumlah',
                                      labelStyle: TextStyle(fontSize: 14 * fem),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8 * fem),
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
                                SizedBox(width: 8 * fem),
                                ElevatedButton(
                                  onPressed: () {
                                    // Add to cart logic
                                    print(
                                        "${produkData[index]['nama']} sejumlah ${quantities[index]} ditambah");
                                  },
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(fontSize: 14 * fem),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
