import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/models/class_model.dart';
import 'package:karatte_kid/models/login_model.dart';
import 'package:karatte_kid/service/navigation_srvices.dart';
import 'package:karatte_kid/widgets/tost.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Apiservice extends ChangeNotifier {
  final String baseUrl = 'https://karate.edusuite.store/';

  bool isLoggedIn = false;
  String? errorMessage = '';
  String? loginKey;
  String? loginSecretKey;

  //  var client = RetryClient(
  //   http.Client(),
  //   whenError: (onError, stackTrace) {
  //     if (onError.toString().contains(AppStrings.connectionClosedError)) {
  //       debugPrint("Retrying....");
  //       return true;
  //     }
  //     return false;
  //   },
  // );
  Duration timeoutDuration = const Duration(seconds: 20);
  List<Map<String, String>> instructors = [];

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

  Future<void> registerInstructors(
    String className,
    List<Map<String, String>> instructors,
  ) async {
    Map<String, dynamic> classData = {
      "class_data": {
        "class_name": className,
      },
      "instructors": instructors,
    };

    debugPrint('Request Body: ${json.encode(classData)}');

    String token = '$loginKey:$loginSecretKey';

    Map<String, String> headers = {
      "Authorization": "Token $token",
      'Accept': 'application/json',
      "Content-Type": "application/json",
    };

    try {
      final response = await http.post(
        Uri.parse(
            '$baseUrl/api/method/institute.institute.api.class.create_or_update_class_with_instructors'),
        headers: headers,
        body: json.encode(classData),
      );

      if (response.statusCode == 200) {
        debugPrint('Instructors registered successfully');
        debugPrint("Full Response ---> : ${response.body}");
      } else {
        debugPrint('Failed to register instructors: ${response.statusCode}');
        debugPrint('Response: ${response.body}');
        throw Exception('API Error: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception('Network Error: $e');
    }
  }

  Future<void> logout() async {
    try {
      debugPrint('SecretKEys: $loginKey:$loginSecretKey');
      Map<String, String> headers = {
        "Authorization": "token$loginKey:$loginSecretKey",
        'Accept': 'application/json',
        "Content-Type": "application/json",
      };
      final response = await http.post(
        Uri.parse("$baseUrl/api/method/logout"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint('resposnse: ${response.body}');
        forceLogout();
      } else {
        debugPrint('Failed to logout. Status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error during logout: $e');
    }
  }

  Future<void> getKeys() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    loginKey = pref.getString('apiKey');
    loginSecretKey = pref.getString('secretkey');
    notifyListeners();
  }

  void storeUserData(bool isLogdin, String? apikey, String? secretKey) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isLogdin', isLogdin);
    pref.setString('apiKey', apikey.toString());
    pref.setString('secretkey', secretKey.toString());
    notifyListeners();
  }

  Future<void> forceLogout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    loginKey = null;
    loginSecretKey = null;
    navigationService.pushNamedAndRemoveUntil(RoutePaths.login);
  }

  Future<ClassModel?> getClassDetails() async {
    ClassModel? classModel;
    try {
      debugPrint("token : $loginKey:$loginSecretKey");
      Map<String, String> headers = {
        "Authorization": "token $loginKey:$loginSecretKey",
        'Accept': 'application/json',
        "Content-Type": "application/json",
      };

      final response = await http.get(
        Uri.parse("$baseUrl/api/resource/Class"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        debugPrint('Full Respose Class Details : $jsonData');
        classModel = ClassModel.fromJson(jsonData);
      } else {
        debugPrint(
            "Failed to load class details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching class details: $e");
      throw Exception("Failed to fetch class details.");
    }

    return classModel;
  }

  Future<bool?> getStudentResorce({
    required String fullname,
    required String email,
    required String phone,
    required String institute,
  }) async {
    bool status = false;

    try {
      debugPrint('Apikey&Scret:  $loginKey  secretKey:$loginSecretKey ');
      Map<String, String> headers = {
        "Authorization": "token $loginKey:$loginSecretKey",
        'Accept': 'application/json',
        "Content-Type": "application/json",
      };

      final body = jsonEncode({
        "full_name": fullname,
        "email": email,
        "phone": phone,
        "institute": institute,
      });

      final response = await http.post(
        Uri.parse("$baseUrl/api/resource/Student"),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        debugPrint("Resgister Full Response : ---> ${response.body}");
        status = true;
      } else {
        debugPrint(
            "Failed to post student resource. Status code: ${response.statusCode}");
        debugPrint('Response: ${response.body}');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception("Failed to create student resource");
    }

    return status;
  }
}
