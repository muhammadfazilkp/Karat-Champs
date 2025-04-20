import 'package:karatte_kid/models/class_model.dart';
import 'package:karatte_kid/service/apiservice.dart';
import 'package:stacked/stacked.dart';

class ClassViewModel extends BaseViewModel {
  ClassViewModel({
    required Apiservice apiservice,
  }) : _apiservice = apiservice;

  final Apiservice _apiservice;
  ClassModel? classModel;

  Future<void> init() async {
    await getClassDetails();
  }

  Future<void> getClassDetails() async {
    classModel = await runBusyFuture(_apiservice.getClassDetails());
    notifyListeners();
  }
}
