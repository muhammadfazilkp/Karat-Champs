import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/service/apiservice.dart';
import 'package:karatte_kid/service/navigation_srvices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class SplsahViewModel extends BaseViewModel {
  SplsahViewModel({
    required Apiservice apiservice,
  }) : _apiservice = apiservice;
  final Apiservice _apiservice;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  Future<void> loginCheck() async {
    _isLoggedIn = true;
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLogdin') ?? false;
    if (_isLoggedIn) {
      navigationService.pushNamedAndRemoveUntil(RoutePaths.bottonav);
    } else {
      navigationService.pushNamed(RoutePaths.login);
    }
    notifyListeners();
  }


  Future<void> init() async {
    loginCheck();
    await _apiservice.loadFromPrefs();
    await _apiservice.getKeys();
  }
}
