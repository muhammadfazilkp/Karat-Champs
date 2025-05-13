import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/models/belt_model.dart';
import 'package:karatte_kid/models/class_model.dart';
import 'package:karatte_kid/models/login_model.dart';
import 'package:karatte_kid/models/student_detail_model.dart';
import 'package:karatte_kid/service/navigation_srvices.dart';
import 'package:karatte_kid/widgets/tost.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Apiservice extends ChangeNotifier {
  final String baseUrl = 'https://karate.edusuite.store/';

  bool isLoggedIn = false;
  String? errorMessage = '';
  String? loginKey;
  String? loginSecretKey;
  bool? isAdmin;
  UserDetails? user;

  var client = RetryClient(
    http.Client(),
    whenError: (onError, stackTrace) {
      if (onError.toString().contains(AppStrings.connectionClosedError)) {
        debugPrint("Retrying....");
        return true;
      }
      return false;
    },
  );

  Duration timeoutDuration = const Duration(seconds: 20);
  List<Map<String, String>> instructors = [];

  Future<LoginResponse?> login(String username, String passcode) async {
    final url =
        Uri.parse('$baseUrl/api/method/institute.institute.api.auth.login');
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
        saveLoginCredential(loginResponse.userDetails);
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

  String get userToken => '$loginKey:$loginSecretKey';

  Map<String, String> get userHeader {
    if (user != null) {
      return {
        'Accept': 'application/json',
        'Authorization': "Token $userToken",
        "Content-Type": "application/json",
      };
    }
    debugPrint('Token is null');
    return {
      'Accept': 'application/json',
      "Content-Type": "application/json",
    };
  }

  Future<void> saveLoginCredential(UserDetails appUser) async {
    user = appUser;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool(Pref.isAdmin, appUser.isAdmin);
    prefs.setString(Pref.appUser, jsonEncode(user!.toJson()));
  }

  Future<void> loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(Pref.appUser);
    if (userJson != null) {
      user = UserDetails.fromJson(jsonDecode(userJson));
    }

    notifyListeners();
  }

  Future<void> registerInstructors(
    String className,
    String address,
    String phone,
    List<Map<String, String>> instructors,
  ) async {
    final Map<String, dynamic> classData = {
      "dojo_data": {
        "dojo_name": className,
        "address": address,
        "phone": phone,
      },
      "instructors": instructors,
    };

    debugPrint('Request Body: ${json.encode(classData)}');
    final String token = '$loginKey:$loginSecretKey';

    final headers = {
      "Authorization": "Token $token",
      'Accept': 'application/json',
      "Content-Type": "application/json",
    };

    try {
      final response = await http.post(
        Uri.parse(
            '$baseUrl/api/method/institute.institute.api.dojo.create_or_update_dojo_with_instructors'),
        headers: headers,
        body: json.encode(classData),
      );

      if (response.statusCode == 200) {
        debugPrint('Instructors registered successfully');
        debugPrint("Full Response ---> : ${response.body}");
        showToast('Instructors registered successfully', color: Colors.green);
      } else {
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
        Uri.parse("$baseUrl/api/resource/Dojo/"),
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
                showToast('registeretion completed  successfully', color: Colors.green);

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

  Future<BeltModel?> getBelt() async {
    BeltModel? beltModel;
    try {
      final response = await client
          .get(
            Uri.parse('$baseUrl/api/resource/Belt'),
            headers: userHeader,
          )
          .timeout(
            timeoutDuration,
            onTimeout: () => http.Response("Request Timeout", 408),
          )
          .catchError((onError) => http.Response("$onError", 404));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        debugPrint("Full Response Belt: $jsonData");
        beltModel = BeltModel.fromJson(jsonData);
      } else {
        debugPrint("Failed to fetch belts. Status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching belts: $e");
    }

    return beltModel;
  }

  Future<Guardian?> getGuardinDetails() async {
    Guardian? guardian;
    try {
      final response = await client
          .get(
            Uri.parse('$baseUrl/api/resource/Guardian'),
            headers: userHeader,
          )
          .timeout(
            timeoutDuration,
            onTimeout: () => http.Response("Request Timeout", 408),
          )
          .catchError((onError) => http.Response("$onError", 404));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        debugPrint("Full Response Guardian: $jsonData");
        guardian = Guardian.fromJson(jsonData);
      } else {
        debugPrint("Failed to fetch Guardian. Status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching Guardian: $e");
    }

    return guardian;
  }

  Future<StudentDetails?> getStudentDetails({
    required String name,
    required String phone,
    required String email,
    required String institute,
  }) async {
    StudentDetails? studentDetails;
    try {

       final requestBody = {
      'full_name': name,
      'email': email,
      'phone': phone,
      'institute': institute,
    };
     debugPrint("Request Body: ${jsonEncode(requestBody)}");
      
      final response = await client
          .post(
              Uri.parse(
                  '$baseUrl/api/resource/Student?filters=[[%22institute%22,%20%22=%22,%20%22$institute%22]]'),
              headers: userHeader,
              body: jsonEncode(requestBody))
          .timeout(
            timeoutDuration,
            onTimeout: () => http.Response("Request Timeout", 408),
          )
          .catchError((onError) => http.Response("$onError", 404));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        debugPrint("Full Response Student Details: $jsonData");
        studentDetails = StudentDetails.fromJson(jsonData);
      } else {
        debugPrint(
            "Failed to fetch Student Details. Status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching Student Details: $e");
    }

    return studentDetails;
  }
}
