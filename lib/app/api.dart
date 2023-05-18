import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'http://192.168.0.102:8000/api';
  dynamic token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tokenString = localStorage.getString('token');
    token = tokenString != null ? jsonDecode(tokenString)['token'] : '';
  }

  auth(data, apiURL) async {
    var fullUrl = Uri.parse(_url + apiURL);
    print(fullUrl);
    print(data);
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiURL) async {
    var fullUrl = Uri.parse(_url + apiURL);
    await _getToken();
    print(fullUrl);
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
