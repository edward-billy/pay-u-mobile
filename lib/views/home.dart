// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:payu/views/history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:payu/app/api.dart';
import 'dart:convert';
import '../main.dart';
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

    if (user != null) {
      setState(() {
        name = user['name'];
      });
    }
  }

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
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
      //   body: SafeArea(
      //   child: Container(
      //     padding: const EdgeInsets.all(15),
      //     child: Column(
      //       children: [
      //         Row(
      //           children: [
      //             const Text(
      //               'Hello, ',
      //               style: TextStyle(
      //                 fontSize: 20,
      //               ),
      //             ),
      //             Text(
      //               '${name}',
      //               style: const TextStyle(
      //                   fontSize: 20, fontWeight: FontWeight.bold),
      //             ),
      //           ],
      //         )
      //       ],
      //     ),
      //   ),
      // ),
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
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoryScreen()),
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
}// TODO Implement this library.