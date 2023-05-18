// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:payu/app/api.dart';
import 'buttonnav.dart';

import 'home.dart';
import 'login.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    loadTotalPenjualan();
  }

  var totalPenjualanBulan,
      totalPenjualan,
      currentPage,
      totalProdukTerjual,
      totalPengunjung;

  Future<void> loadTotalPenjualan() async {
    var res = await Network().getData('/dashboard');
    print(res);
    if (res.statusCode == 200) {
      var body = json.decode(res.body);
      setState(() {
        totalPenjualan = body['totalPenjualan'];
        totalPenjualanBulan = body['totalPenjualanBulan'];
        totalProdukTerjual = body['totalProdukTerjual'];
        totalPengunjung = body['totalPengunjung'];
        print(body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Total Penjualan: $totalPenjualan',
            style: const TextStyle(fontSize: 16),
          ),
          Text('PenjualanBulan: $totalPenjualanBulan',
              style: const TextStyle(fontSize: 16)),
          Text('ProdukTerjual: $totalProdukTerjual',
              style: const TextStyle(fontSize: 16)),
          Text('Pengunjung: $totalPengunjung',
              style: const TextStyle(fontSize: 16)),
        ],
      ),
      // bottomNavigationBar: BottomNav(
      //   currentIndex: 0,
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
