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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Transaksi $invoiceId'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            List<dynamic> historyData = snapshot.data!;

            // Calculate the total
            int total = historyData.fold(
                0, (sum, item) => sum + int.parse(item['harga'].toString()));

            // Format the total
            String formattedTotal =
                NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                    .format(total);

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Invoice ID: $invoiceId'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Nama Customer: $nama'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Nama Kasir: $name'),
                    ],
                  ),
                  SizedBox(height: 20),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Produk')),
                      DataColumn(label: Text('Jumlah')),
                      DataColumn(label: Text('Harga')),
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
                          ],
                        );
                      }),
                      DataRow(
                        cells: [
                          DataCell(Text('Total',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text(formattedTotal)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          }
          return Center(child: Text('No data available'));
        },
      ),
    );
  }
}
