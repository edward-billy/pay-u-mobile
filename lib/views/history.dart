import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:payu/app/api.dart';
import 'buttonnav.dart';

import 'home.dart';
import 'login.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> historyData = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child: DataTable(
            columns: [
              const DataColumn(label: Text('No')),
              const DataColumn(label: Text('Invoice ID')),
              const DataColumn(label: Text('Nama Kasir')),
              const DataColumn(label: Text('Nama Customer')),
              const DataColumn(label: Text('Total')),
              const DataColumn(label: Text('Action')),
            ],
            rows: List<DataRow>.generate(
              historyData.length,
              (index) => DataRow(
                cells: [
                  DataCell(Text((index + 1).toString())),
                  DataCell(Text(historyData[index]['invoiceId'].toString())),
                  DataCell(Text(historyData[index]['name'].toString())),
                  DataCell(Text(historyData[index]['nama'].toString())),
                  DataCell(Text('Rp. ${historyData[index]['total']}-')),
                  DataCell(
                    ElevatedButton(
                      onPressed: () {
                        // Handle button press
                        // You can navigate to the detail screen here
                      },
                      child: const Text('Detail'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNav(
      //   currentIndex: 2,
      //   onTabChanged: (index) {},
      // ),
    );
  }

  void logout() async {
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      localStorage.remove('user');
      localStorage.remove('token');
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
  }
}

Future<List<Map<String, dynamic>>> getHistoryData() async {
  var res = await Network().getData('/history');
  var body = json.decode(res.body);
  // print(body['data']['data']);
  if (body['data'] != null) {
    return List<Map<String, dynamic>>.from(body['data']['data']);
  }
  return []; // Return an empty list if there's an error or no data
}
