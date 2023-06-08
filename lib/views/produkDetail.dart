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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(0.4), // Kolom pertama mengambil 40% lebar
            1: FlexColumnWidth(0.6), // Kolom kedua mengambil 60% lebar
          },
          children: [
            _buildTableRow('Nama Produk', nama),
            _buildTableRow('Kategori', kategori),
            _buildTableRow('Deskripsi', deskripsi),
            _buildTableRow('Stok', stok),
            _buildTableRow(
                'Harga',
                NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp ',
                ).format(double.parse(harga) ?? '0')),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
