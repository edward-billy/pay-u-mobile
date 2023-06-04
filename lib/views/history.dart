import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:payu/app/api.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

import 'historyDetail.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> historyData = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    loadHistoryData();
  }

  Future<void> loadHistoryData() async {
    List<Map<String, dynamic>> data = await getHistoryData();
    setState(() {
      historyData = data;
      print(historyData);
    });
  }

  Future<void> generateAndDownloadPDF() async {
    final pdf = pw.Document();
// Get the current date
    final currentDate = DateFormat('dd-MMM-yyy').format(DateTime.now());

    // Create the PDF content
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text('History Data', style: const pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 10),
              pw.Text('Date: $currentDate',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                data: <List<String>>[
                  <String>[
                    'No',
                    'Invoice ID',
                    'Nama Kasir',
                    'Nama Customer',
                    'Total'
                  ],
                  ...historyData.map((data) => [
                        (historyData.indexOf(data) + 1).toString(),
                        data['invoiceId'].toString(),
                        data['name'].toString(),
                        data['nama'].toString(),
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp ',
                        ).format(data['total']),
                      ]),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Save the PDF document
    final directory = Directory("/storage/emulated/0/Download");
    final filePath = '${directory.path}/dataPenjualan_$currentDate.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Open the PDF document for sharing or downloading
    // For example, you can use the 'share' package to share the file via other apps
    // or provide a download link to the user using the 'url_launcher' package.
    // Here, we'll print the file path for demonstration purposes.
    print('PDF file saved at: $filePath');
    _showMsg('PDF file saved at: $filePath');
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
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DataTable(
                columns: const [
                  DataColumn(label: Text('No')),
                  DataColumn(label: Text('Invoice ID')),
                  DataColumn(label: Text('Nama Kasir')),
                  DataColumn(label: Text('Nama Customer')),
                  DataColumn(label: Text('Total')),
                  DataColumn(label: Text('Action')),
                ],
                rows: List<DataRow>.generate(
                  historyData.length,
                  (index) => DataRow(
                    cells: [
                      DataCell(Text((index + 1).toString())),
                      DataCell(
                          Text(historyData[index]['invoiceId'].toString())),
                      DataCell(Text(historyData[index]['name'].toString())),
                      DataCell(Text(historyData[index]['nama'].toString())),
                      DataCell(
                        Text(
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp ',
                          ).format(historyData[index]['total']),
                        ),
                      ),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoryDetail(
                                  invoiceId: historyData[index]['invoiceId']
                                      .toString(),
                                  data: getHistoryDetail((index + 1)),
                                  nama: historyData[index]['nama'].toString(),
                                  name: historyData[index]['name'].toString(),
                                ),
                              ),
                            );
                          },
                          child: const Text('Detail'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: generateAndDownloadPDF,
                child: Text('Download PDF'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getHistoryData() async {
    var res = await Network().getData('/history');
    var body = json.decode(res.body);
    if (body['data'] != null) {
      return List<Map<String, dynamic>>.from(body['data']['data']);
    }
    return [];
  }

  Future<List> getHistoryDetail(id) async {
    var res = await Network().getData('/history/$id');
    var body = json.decode(res.body);
    if (body['data'] != null) {
      return List<dynamic>.from(body['data']);
    }
    return [];
  }
}
