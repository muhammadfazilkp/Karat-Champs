import 'package:karatte_kid/models/login_model.dart';
import 'package:karatte_kid/service/apiservice.dart';
import 'package:stacked/stacked.dart';

class HomeViewmodel extends BaseViewModel {
  HomeViewmodel({required Apiservice apiservice}) : _apiservice = apiservice;
  final Apiservice _apiservice;
  UserDetails? get user => _apiservice.user;

  Future<void> logout() async {
    await runBusyFuture(_apiservice.logout());
  }

  void init() async {
    _apiservice.getKeys();

    

  }
}
