import 'package:karatte_kid/models/class_model.dart';
import 'package:karatte_kid/models/student_detail_model.dart';
import 'package:karatte_kid/service/apiservice.dart';
import 'package:stacked/stacked.dart';

import '../../models/login_model.dart';

class ClassViewModel extends BaseViewModel {
  ClassViewModel({
    required Apiservice apiservice,
  }) : _apiservice = apiservice;

  final Apiservice _apiservice;
  UserDetails? get user => _apiservice.user;

  ClassModel? classModel;
  StudentDetails? studentDetails;

  Future<void> init() async {
    await getClassDetails();
  }

  Future<void> getClassDetails() async {
    classModel = await runBusyFuture(_apiservice.getClassDetails());
    notifyListeners();
  }

  Future<void> getInstituteClassDetails({required String institute}) async {
    studentDetails = await runBusyFuture(_apiservice.getStudentDetails(
      
        institute: institute));

    notifyListeners();
  }
}
