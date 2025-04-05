import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:karatte_kid/models/login_model.dart';
import 'package:karatte_kid/widgets/tost.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Apiservice extends ChangeNotifier {
  final String baseUrl = 'https://karate.edusuite.store/';

  bool isLoggedIn = false;
  String? errorMessage = '';

  Future<LoginResponse?> login(String username, String passcode) async {
    final url =
        Uri.parse('$baseUrl/api/method/rest_auth.rest_auth.api.auth.login');
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final body = {
        'username': username,
        'password': passcode,
      };

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);
      debugPrint("Full response Login : $data");

      if (response.statusCode == 200 && data['message'] == "Logged In") {
        final loginResponse = LoginResponse.fromJson(data);
        isLoggedIn = true;
        storeUserData(
          isLoggedIn,
          loginResponse.keyDetails.apiKey,
          loginResponse.keyDetails.apiSecret,
        );
        debugPrint('key: ${loginResponse.keyDetails.apiKey}');
        return loginResponse;
      } else {
        errorMessage = data['message'] ?? 'Login failed';
        debugPrint("Login failed: $errorMessage");
        showToast(errorMessage!);
        return null;
      }
    } catch (e) {
      errorMessage = 'An error occurred: $e';
      debugPrint(errorMessage);
      return null;
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
