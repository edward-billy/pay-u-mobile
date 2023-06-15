import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryDetail extends StatelessWidget {
  final String invoiceId;
  final String nama;
  final String name;
  final Future<List<dynamic>> data;

  const HistoryDetail({
    Key? key,
    required this.invoiceId,
    required this.nama,
    required this.name,
    required this.data,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Transaksi $invoiceId'),
      ),
      backgroundColor: const Color(0xff151515),
      body: FutureBuilder<List<dynamic>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            List<dynamic> historyData = snapshot.data!;
            // Calculate the total
            int total = historyData.fold(
                0,
                (sum, item) =>
                    sum +
                    int.parse(item['harga'].toString()) *
                        int.parse(item['jumlah'].toString()));

            // Format the total
            String formattedTotal =
                NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                    .format(total);

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Invoice ID: $invoiceId'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Nama Customer: $nama'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Nama Kasir: $name'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('No')),
                        DataColumn(label: Text('Produk')),
                        DataColumn(label: Text('Jumlah')),
                        DataColumn(label: Text('Harga')),
                        DataColumn(label: Text('Total Harga')),
                      ],
                      rows: [
                        ...historyData.asMap().entries.map((entry) {
                          int index = entry.key + 1;
                          var item = entry.value;
                          return DataRow(
                            cells: [
                              DataCell(Text(index.toString())),
                              DataCell(Text(item['namaproduk'].toString())),
                              DataCell(Text(item['jumlah'].toString())),
                              DataCell(Text(NumberFormat.currency(
                                      locale: 'id', symbol: 'Rp ')
                                  .format(item['harga']))),
                              DataCell(Text(NumberFormat.currency(
                                      locale: 'id', symbol: 'Rp ')
                                  .format(item['harga'] * item['jumlah']))),
                            ],
                          );
                        }),
                        DataRow(
                          cells: [
                            const DataCell(Text('Total',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            const DataCell(Text('')),
                            const DataCell(Text('')),
                            const DataCell(Text('')),
                            DataCell(Text(formattedTotal)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}
