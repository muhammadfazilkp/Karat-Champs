import 'package:karatte_kid/service/apiservice.dart';
import 'package:stacked/stacked.dart';

class HomeViewmodel extends BaseViewModel {
  HomeViewmodel({required Apiservice apiservice}) : _apiservice = apiservice;
  final Apiservice _apiservice;

  Future<void> logout() async {
    await runBusyFuture(_apiservice.logout());
  }
  void init(){
    _apiservice.getKeys();
  }
}
