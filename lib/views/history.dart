import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:payu/app/api.dart';

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

  int currentPage = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay-U | History'),
        backgroundColor: const Color(0xff151515),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new),
            onPressed: () {
              logout();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columns: [
            const DataColumn(label: Text('No')),
            const DataColumn(label: Text('Invoice ID')),
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
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Dashboard"),
          NavigationDestination(
              icon: Icon(Icons.shopping_cart), label: "Kasir"),
          NavigationDestination(icon: Icon(Icons.history), label: "History"),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onDestinationSelected: (int index) async {
          setState(() {
            currentPage = index;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          }
        },
        selectedIndex: currentPage,
      ),
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
