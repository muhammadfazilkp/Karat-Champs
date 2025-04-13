import 'package:karatte_kid/service/apiservice.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  ProfileViewModel({required Apiservice apiservice}) : _apiservice = apiservice;

  final Apiservice _apiservice;
  Future<void> logout() async {
    await runBusyFuture(_apiservice.logout());
  }
}
