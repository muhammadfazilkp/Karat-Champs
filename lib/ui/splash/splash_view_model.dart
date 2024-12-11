import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/service/navigation_srvices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class SplsahViewModel extends BaseViewModel {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  Future<void> loginCheck() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLogdin') ?? false;
    if (_isLoggedIn) {
      navigationService.pushNamedAndRemoveUntil(RoutePaths.homeview);
    } else {
      navigationService.pushNamed(RoutePaths.login);
    }
    notifyListeners();
  }

}
