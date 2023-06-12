import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:payu/app/api.dart';
import 'buttonnav.dart';

import 'home.dart';
import 'login.dart';

class KasirScreen extends StatefulWidget {
  const KasirScreen({super.key});

  @override
  State<KasirScreen> createState() => KasirScreeneState();
}

class KasirScreeneState extends State<KasirScreen> {
  @override
  Widget build(BuildContext context) {
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
  }
}
