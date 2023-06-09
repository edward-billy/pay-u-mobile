import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  static String _url = 'http://192.168.0.102:8000/api';
  dynamic token;
  // dynamic cookieManager;

  auth(data, apiURL) async {
    var fullUrl = Uri.parse(_url + apiURL);
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  updateProfile(String newName, String newEmail, apiURL) async {
    var url = Uri.parse(_url + apiURL);
    await _getToken();
    var headers = _setHeaders();
    var body = json.encode({'name': newName, 'email': newEmail});
    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData['message']);
    } else {
      print('Gagal memperbarui profil');
    }
  }

  getData(apiURL) async {
    var fullUrl = Uri.parse(_url + apiURL);
    await _getToken();

    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

  postData(data, apiURL) async {
    var fullUrl = Uri.parse(_url + apiURL);
    await _getToken();
    print(fullUrl);

    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tokenString = localStorage.getString('token');
    token = tokenString != null ? jsonDecode(tokenString)['token'] : '';
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
