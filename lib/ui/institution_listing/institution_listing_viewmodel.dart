import 'package:karatte_kid/models/class_model.dart';
import 'package:karatte_kid/service/apiservice.dart';
import 'package:stacked/stacked.dart';

class InstitutionListingViewmodel extends BaseViewModel {
  InstitutionListingViewmodel({required Apiservice apiservice})
      : _apiservice = apiservice;

  final Apiservice _apiservice;
  ClassModel? classModel;
  Future<void> getClassDetails() async {
    classModel = await runBusyFuture(_apiservice.getClassDetails());
    notifyListeners();
  }
}
