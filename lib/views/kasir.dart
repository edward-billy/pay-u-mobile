import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:payu/views/cartKategori.dart';
import 'package:payu/app/api.dart';

class KasirScreen extends StatelessWidget {
  const KasirScreen({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          columns: const [
            DataColumn(label: Text('No')),
            DataColumn(label: Text('Nama Produk')),
            DataColumn(label: Text('Kategori')),
            DataColumn(label: Text('Deskripsi')),
            DataColumn(label: Text('Stok')),
            DataColumn(label: Text('Harga')),
            DataColumn(label: Text('Action')),
          ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNav(
      //   currentIndex: 2,
      //   onTabChanged: (index) {},
      // ),
    );
=======
    double baseWidth = 1194;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.fromLTRB(39 * fem, 0 * fem, 26 * fem, 53 * fem),
        padding: EdgeInsets.fromLTRB(28.81 * fem, 19 * fem, 28 * fem, 20 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff313131),
          borderRadius: BorderRadius.circular(10 * fem),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 125 * fem,
                  width: 200 * fem,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => cartKategoriScreen(
                            data: getData(1),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Makanan",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 125 * fem,
                  width: 200 * fem,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => cartKategoriScreen(
                            data: getData(2),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Minuman",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 125 * fem,
                  width: 200 * fem,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => cartKategoriScreen(
                            data: getData(3),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Cemilan",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 125 * fem,
                  width: 200 * fem,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => cartKategoriScreen(
                            data: getData(4),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Pakaian",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 125 * fem,
                  width: 200 * fem,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => cartKategoriScreen(
                            data: getData(5),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Elektronik",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 125 * fem,
                  width: 200 * fem,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => cartKategoriScreen(
                            data: getData(6),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Furnitur",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 125 * fem,
                  width: 200 * fem,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => cartKategoriScreen(
                            data: getData(7),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Kecantikan",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 125 * fem,
                  width: 200 * fem,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => cartKategoriScreen(
                            data: getData(8),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Olahraga",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 125 * fem,
                  width: 200 * fem,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => cartKategoriScreen(
                            data: getData(9),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Kesehatan",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  height: 125 * fem,
                  width: 200 * fem,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => cartKategoriScreen(
                            data: getData(10),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Hobi",
                      style: TextStyle(fontSize: 30),
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

  Future<List> getData(int kategori) async {
    var res = await Network().getData("/cashier/kategori/$kategori");
    var body = json.decode(res.body);
    if (body['data'] != null) {
      // print(body['data']);
      return List<dynamic>.from(body['data']);
    }
    return [];
>>>>>>> 3d342bd80be47fb198ecdba13ae93c17f9242d31
  }
}
