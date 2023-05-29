// ignore: file_names
import 'package:flutter/material.dart';

class ProdukDetail extends StatelessWidget {
  final String nama;
  final String kategori;
  final String deskripsi;
  final String stok;
  final String harga;
  final int id;
  final Future<List<Map<String, dynamic>>> data;

  const ProdukDetail(
      {Key? key,
      required this.nama,
      required this.kategori,
      required this.deskripsi,
      required this.stok,
      required this.harga,
      required this.id,
      required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nama),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Data not found.'),
            );
          }
          final produkData = snapshot.data!;
          final produk = produkData.first;

          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama: $nama',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text('Kategori: $kategori'),
                Text('Deskripsi: $deskripsi'),
                Text('Stok: $stok'),
                Text('Harga: $harga'),
                // Tampilkan informasi lainnya sesuai kebutuhan
              ],
            ),
          );
        },
      ),
    );
  }
}
