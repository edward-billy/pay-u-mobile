import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:payu/app/api.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
  final Function(String) onUpdateProfile;

  const ProfileScreen({required this.onUpdateProfile});
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isObscurePassword = true;
  String name = '';
  String email = '';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String updatedName = '';
  String updatedEmail = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // Set initial values to the controllers

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
        nameController.text = user['name'];
        emailController.text = user['email'];
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
                  controller: nameController,
                  onChanged: (value) {
                    setState(() {
                      updatedName = value;
                    });
                  },
                ),
                TextField(
                  controller: emailController,
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
                        if (updatedName == '') {
                          updatedName = nameController.text;
                        }
                        print("email: $email");
                        if (updatedEmail == '') {
                          updatedEmail = emailController.text;
                        }
                        updateProfile(updatedName, updatedEmail);
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

  Future<void> updateProfile(String newName, String newEmail) async {
    print(newName);

    try {
      await Network().updateProfile(newName, newEmail, '/profile');
      setState(() {
        name = newName; // Update the local name variable
        email = newEmail; // Update the local email variable
      });

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var user = jsonDecode(localStorage.getString('user') ?? '');

      if (user != null) {
        var updatedUser = {
          ...user,
          'name': newName,
          'email': newEmail,
        };

        localStorage.setString('user', jsonEncode(updatedUser));
      }

      _showMsg("Profile updated successfully");
      widget.onUpdateProfile(newName);
    } catch (error) {
      print('An error occurred: $error');
    }
  }

  // Future<void> updateProfile(String newName, String newEmail) async {
  //   print(newName);
  //   try {
  //     await Network().updateProfile(newName, newEmail, '/profile');
  //     setState(() {
  //       name = newName; // Memperbarui nilai name
  //       email = newEmail; // Memperbarui nilai email
  //     });
  //     _showMsg("Profile updated successfully");
  //     widget.onUpdateProfile(newName);
  //   } catch (error) {
  //     print('Terjadi kesalahan: $error');
  //   }
  // }
}
