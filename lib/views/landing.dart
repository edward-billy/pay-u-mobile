import 'package:flutter/material.dart';
import 'package:payu/views/register.dart';

import 'login.dart';

class landing extends StatelessWidget {
  const landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                    child: const Text(
                      "LET'S START YOUR EASY DAY",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 150),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 53, 51, 51),
                            minimumSize: Size(150, 60),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1),
                            ),
                            side: BorderSide(width: 1, color: Colors.white)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: const Text(
                          'REGISTER',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: Size(150, 60),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/cashierbig.png'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
