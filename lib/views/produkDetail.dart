import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProdukDetail extends StatelessWidget {
  final int id;
  final String nama;
  final String kategori;
  final String deskripsi;
  final String stok;
  final String harga;
  final Future<List<Map<String, dynamic>>> data;

  ProdukDetail({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.deskripsi,
    required this.stok,
    required this.harga,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
      ),
      backgroundColor: const Color(0xff151515),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.6,
          heightFactor: 0.6,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 240, 236, 236),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
                borderRadius: BorderRadius.circular(2),
                color: Color.fromARGB(255, 64, 64, 64)),
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    Text(
                      'Detail Produk',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Color.fromARGB(255, 44, 46, 48),
                      ),
                    ),
                    Text(
                      'Detail Produk',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 231, 233, 235),
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: 30), // Add spacing between the Stack and the rows
                Row(
                  children: [
                    SizedBox(width: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text('Nama Produk'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text('Kategori'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text('Deskripsi'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text('Stok'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text('Harga'),
                        ),
                      ],
                    ),
                    SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(nama),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(kategori),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(deskripsi),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(stok),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(harga),
                        ),
                      ],
                    ),
                    SizedBox(width: 30)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
