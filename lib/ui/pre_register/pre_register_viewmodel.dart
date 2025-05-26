import 'package:karatte_kid/models/student_detail_model.dart';
import 'package:karatte_kid/service/apiservice.dart';
import 'package:stacked/stacked.dart';

import '../../models/login_model.dart';

class PreRegisterViewmodel extends BaseViewModel {
  PreRegisterViewmodel({required Apiservice apiservice})
      : _apiservice = apiservice;
  final Apiservice _apiservice;
  StudentDetails? studentDetails;
  UserDetails? get user => _apiservice.user;

  Future<void> getInstituteClassDetails({required String institute}) async {
    studentDetails = await runBusyFuture(
        _apiservice.getStudentDetails(institute: institute));

    notifyListeners();
  }
}
