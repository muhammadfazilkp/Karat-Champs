import 'package:karatte_kid/service/apiservice.dart';
import 'package:karatte_kid/ui/bottom_nav/bottomnav_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  ProfileViewModel(
      {required Apiservice apiservice,
      required BottomnavViewmodel bottomnavViewmodel})
      : _bottomnavViewmodel = bottomnavViewmodel,
        _apiservice = apiservice;

  final Apiservice _apiservice;
  final BottomnavViewmodel _bottomnavViewmodel;
  Future<void> logout() async {
    await runBusyFuture(_apiservice.logout());
  }

  void goHome() => _bottomnavViewmodel.setIndex(0);
}
