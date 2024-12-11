import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:karatte_kid/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Apiservice extends ChangeNotifier {
  final String baseUrl = 'https://karate.edusuite.store/';
  bool? isLogdin = false;
  Future<LoginResponse> login(String username, String passcode) async {
    LoginResponse? loginResponse;
    final url =
        Uri.parse('$baseUrl/api/method/rest_auth.rest_auth.api.auth.login');
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      Map<String, dynamic> body = {
        'username': username,
        'password': passcode,
      };

      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        debugPrint("Full response Login : $data ");
        loginResponse = LoginResponse.fromJson(data);
        isLogdin = true;
        storeUserData(isLogdin!, loginResponse.keyDetails.apiKey,
            loginResponse.keyDetails.apiSecret);
            debugPrint('key: ${loginResponse.keyDetails.apiKey}');
        return LoginResponse.fromJson(data);
      } else {
        throw Exception(
            'Failed to login: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  void storeUserData(bool isLogdin, String? apikey, String? secretKey) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isLogdin', isLogdin);
    pref.setString('apiKey', apikey.toString());
    pref.setString('secretkey', secretKey.toString());
    notifyListeners();
  }
}
