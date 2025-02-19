import 'package:flutter/material.dart';
import 'package:karatte_kid/models/login_model.dart';
import 'package:karatte_kid/service/apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class LoginViewmodel extends BaseViewModel {
  LoginViewmodel({required Apiservice apiservice}) : _apiservice = apiservice;

  final Apiservice _apiservice;
  LoginResponse? loginResponse;
  final usernameController = TextEditingController();
  final passcodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool? isLogedIn = false;
  bool isPasswordVisible = false;
  void init() {}

  Future<void> login(String username, String passcode) async {
    try {
      loginResponse =
          await runBusyFuture(_apiservice.login(username, passcode));
      if (loginResponse != null) {
        isLogedIn = true;
        debugPrint('Loginresponse: $loginResponse');
        notifyListeners();
      }
    } catch (e) {
      throw error(e);
    }
  }

  getUserData(bool isLogdin, String? logkey, String? secretKey) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isLogin', isLogdin);
    pref.setString('apiKey', logkey.toString());
    pref.setString('secretKey', secretKey.toString());
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }
}
