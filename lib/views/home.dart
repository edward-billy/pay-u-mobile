// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:payu/views/dashboard.dart';
import 'package:payu/views/history.dart';
import 'package:payu/views/produk.dart';
import 'package:payu/views/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:payu/app/api.dart';
import 'dart:convert';
import 'buttonnav.dart';
import 'kasir.dart';
import 'login.dart';

class Home extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user') ?? '');

    // if (user != null) {
    //   setState(() {
    //     name = user['name'];
    //   });
    // }
  }

  void updateAppBarName(String newName) {
    setState(() {
      name = newName; // Mengubah nilai name
    });
  }

  int currentPage = 0;

  void onTabChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadUserData();
    return Scaffold(
      backgroundColor: const Color(0xff151515),
      appBar: AppBar(
        title: Text('Pay-U | Selamat Datang, $name'),
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
      body: IndexedStack(
        index: currentPage,
        children: [
          DashboardScreen(),
          ProdukScreen(),
          KasirScreen(),
          HistoryScreen(),
          ProfileScreen(
            onUpdateProfile: updateAppBarName,
          )
        ],
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: currentPage,
        onTabChanged: onTabChanged,
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
