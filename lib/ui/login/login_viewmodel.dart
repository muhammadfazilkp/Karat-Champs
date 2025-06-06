import 'package:flutter/material.dart';
import 'package:karatte_kid/models/login_model.dart';
import 'package:karatte_kid/service/apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../constant/app_constant.dart';
import '../../service/navigation_srvices.dart';

class LoginViewmodel extends BaseViewModel {
  LoginViewmodel({required Apiservice apiservice}) : _apiservice = apiservice;

  final Apiservice _apiservice;
  LoginResponse? loginResponse;
  final usernameController = TextEditingController();
  final passcodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool? isLogedIn = false;
  String errorMessgae = '';
  bool isPasswordVisible = false;
  void init() {}

  Future<void> login(String username, String passcode) async {
    loginResponse = await runBusyFuture(_apiservice.login(username, passcode));
    isLogedIn = true;
    if (loginResponse !=null)  {
      navigationService.pushNamedAndRemoveUntil(RoutePaths.bottonav);
    }
    debugPrint('Loginresponse: $loginResponse');
    notifyListeners();
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
