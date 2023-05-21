import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:payu/views/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:payu/app/api.dart';
import 'buttonnav.dart';
import 'login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isObscurePassword = true;
  String name = '';
  String email = '';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String updatedName = '';
  String updatedEmail = '';
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
        email = user['email'];
      });
    }
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
        body: Container(
          padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                const SizedBox(height: 30),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      updatedName = value;
                    });
                  },
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      updatedEmail = value;
                    });
                  },
                ),
                // buildTextField(
                //     "Role", "Kasir / manager", false), //ini jadii drop down
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        updateUserProfile(updatedName, updatedEmail);
                      },
                      child: const Text("UPDATE",
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.white)),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Future<void> updateUserProfile(String name, String email) async {
    var data = {
      'name': name,
      'email': email,
    };
    final res = await Network().update(data, '/profile');
    var body = json.decode(res.body);

    if (body['success']) {
      // Perbarui profil berhasil
      print('Profile updated successfully');
    } else {
      // Gagal memperbarui profil
      print('Failed to update profile');
    }
  }
}

Widget buildTextField(String labelText, String placeholder,
    {required TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: TextField(
      // obscureText: isPasswordTextField ? isObscurePassword : false,
      decoration: InputDecoration(
          // suffixIcon: isPasswordTextField
          //     ? IconButton(
          //         icon: Icon(Icons.remove_red_eye, color: Colors.grey),
          //         onPressed: () {},
          //       )
          //     : null,
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
    ),
  );
}
